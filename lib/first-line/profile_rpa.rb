module Mass
    class ProfileRPA < Mass::Profile
        @@buffer_driver = nil
        attr_accessor :headless

        def self.buffer_driver
            @@buffer_driver
        end

        def self.buffer_driver=(o)
            @@buffer_driver = o
        end

        def initialize(desc)
            super(desc)
            headless = true
        end

        def self.domain
            raise "Method domain of ProfileRPA must be implemented on each child class."
        end

        # resolving the redirection from facebook_2 to facebook, or linkedin_2 to
        # more infromation here: https://github.com/VyMECO/mass.public/issues/93
        #
        # Parameters:
        # - lead_descriptor: hash descriptor of a lead
        # - field_1: field for storing the URL type 1 that must be realized.
        # - field_2: field for storing the URL type 2 that redirets to the URL type .
        # - logger: object to write log. Optional. Default: nil.
        #
        def resolve_dual_url(lead_descriptor, 
            field_1:,
            field_2:,
            logger: nil
        ) 
            l = logger || BlackStack::DummyLogger.new(nil)
            k = lead_descriptor
  
            l.logs "Resolving dual-url redirection #{k[field_2].to_s.blue}... "
            if !k[field_2].nil? && k[field_1].nil?
                h_filters = {}
                h_filters[field_2.to_s] = k[field_2]
                lead = Mass::Lead.page(
                    id_account: lead_descriptor['id_account'],
                    page: 1,
                    limit: 1,
                    filters: h_filters
                ).first
                if lead
                    l.logf 'done'.green + " (field_2 already registered in the database.)"
                else
                    driver.get(k[field_2])
                    sleep(5)
                    k[field_1] = driver.current_url
                    #ret.select { |k2| k2['lead'][field_2] ==  }
                    l.logf 'done'.green + " (#{k[field_1].to_s.blue})"
                end
            else
                if k[field_2].nil?
                    l.logf 'skip'.yellow + " (no field_2)"
                else
                    l.logf 'skip'.yellow + " (no dual-url redirection needed)"
                end
            end
        end # def resolve_dual_url

        # for internal use only. users should call `send_request` instead.
        def close_popups(logger:nil)
            raise "Method close_popups of ProfileRPA must be implemented on each child class."
        end # def close_popups

        # start the adspower server for headless mode, if it is not already started and if headless is activated.
        def self.start_headless_server(headless: true, logger:nil)
            l = logger || BlackStack::DummyLogger.new(nil)
            # check if the rpa.rb process is running manually
            l.logs "Starting AdsPower headless server?... "
            unless headless
                l.logf "no".yellow + " (headless is disabled in the command line)"
            else
                l.logf "yes".green + " (headless is enabled)"

                # creating an AdsPower client
                l.logs "Creating AdsPower client... "
                c = AdsPowerClient.new(key: ADSPOWER_API_KEY)
                l.logf 'done'.green

                # starting adspower server
                l.logs "Is headless server already running?... "
                if c.online?
                    l.logf "yes".green
                else
                    l.logf "no".yellow
                    
                    l.logs "Starting AdsPower server... "
                    c.server_start 
                    l.logf 'done'.green
                end
            end # if parser.value('manual')
        end

        # stop the adspower server for headless mode, if it is not already stopped and if headless is activated.
        def self.clear_driver
            self.buffer_driver = nil
        end

        # close all tabs except one
        # do this only if there are more than one tab
        # do this in order to avoid the browser show up if it is not necesasry.
        def one_tab
            handles = self.class.buffer_driver.window_handles
            if handles.size > 1
                chosen = handles.pop
                handles.each { |handle|
                    self.class.buffer_driver.switch_to.window(handle)
                    self.class.buffer_driver.close # don't use quit, because you don't want to kill the chromedriver
                }
                self.class.buffer_driver.switch_to.window(chosen)
            end
        end # def one_tab
=begin
        # scroll down n times
        def scroll_down(n)
            driver = self.driver
            i = 0
            while (i<n)
                i += 1
                step = self.desc['scrolling_step'] + rand(self.desc['scrolling_step_random'].to_i)

                # scroll down to the 3th post
                #
                driver.execute_script("window.scrollBy(0, #{i*1000});");
            
                # add delay to wait for the AJAX
                # 
                sleep(10+rand(5))
            end
        end # def scroll_down
=end
        # Allow or Block a site to perform multiple downloads.
        # Parameters:
        # - status: :allow or :block
        # - domain: the domain of the site to allow or block.
        # - secure: true or false
        # - www: true or false
        #
        # Reference: 
        # - https://github.com/VyMECO/mass/issues/43
        # - https://stackoverflow.com/questions/66659465/python-manually-config-chrome-settings-by-selenium-remotedriver 
        #
        def automatic_downloads(
            status:, 
            domain:,
            secure:true,
            www:true
        ) 
            err = []
            err << "The status must be :allow or :block." if ![:allow, :block].include?(status)
            err << "#{domain.to_s} is not a valid domain" if !domain.to_s.strip.downcase.valid_domain?
            raise err.join("\n") if err.size > 0

            site_url = secure ? "https://" : "http://"
            site_url += www ? "www." : ""
            site_url += domain.to_s
            site_url += secure ? ":443" : ""

            url = "chrome://settings/content/siteDetails?site=#{CGI.escape(site_url)}"
            self.driver.get(url)
            temp = self.driver.execute_script("return document.querySelector('settings-ui').shadowRoot.querySelector('settings-main#main').shadowRoot.querySelector('settings-basic-page')")
            rules = self.driver.execute_script("return arguments[0].shadowRoot.querySelector('settings-privacy-page').shadowRoot.querySelector('settings-animated-pages#pages settings-subpage site-details').shadowRoot.querySelector('div.list-frame:not(div>div.list-frame)')", temp)
            automaticDownloads = self.driver.execute_script("return arguments[0].querySelector('site-details-permission[label=\"Automatic downloads\"]').shadowRoot.querySelector('#permission')", rules)
            
            self.driver.execute_script("arguments[0].scrollIntoView()", automaticDownloads)
            automaticDownloads.click()
            automaticDownloads.find_element(:id => status.to_s).click()
        end # def automatic_downloads

        # Waits for the presence of a file in specified file paths within a given timeout period.
        # This function checks each file path in the provided array and returns the path of the
        # first file it finds to exist. It raises an exception if none of the files are found
        # within the specified timeout.
        #
        # @param file_paths [Array<String>] An array of file paths to check for the file's existence.
        # @param timeout [Integer] The maximum number of seconds to wait for the file to appear.
        #                          Default is 30 seconds.
        #
        # @return [String] The path of the first file found in `file_paths`.
        # @raise [RuntimeError] If no file is found within the specified timeout, raises an error with a message 
        #                       listing the paths that were checked and the timeout duration.
        #
        # @example
        #   wait_for_file(['/path/to/file1', '/path/to/file2'], timeout: 60)
        #   # => "/path/to/file1" (if the file appears within 60 seconds)
        #
        def wait_for_file(file_paths, timeout = 30)
            Timeout.timeout(timeout) do
              loop do
                file_paths.each do |path|
                  return path if File.exist?(path)
                end
                sleep(1)
              end
            end
        rescue Timeout::Error
            raise "Downloaded file not found in paths #{file_paths.join(',')} after #{timeout} seconds."
        end


        # Retrieves the URL of a file stored in Dropbox with a timeout mechanism.
        # This function continuously attempts to retrieve the file URL until it 
        # becomes available in Dropbox, up to a specified maximum wait time.
        #
        # @param path [String] The path to the file in Dropbox.
        # @param max_wait [Integer] Maximum time to wait (in seconds) for the file to 
        #                            appear in Dropbox. Default is 30 seconds.
        # @param interval [Integer] Time interval (in seconds) between each retry 
        #                            attempt. Default is 2 seconds.
        #
        # @return [String] The URL of the file in Dropbox, with the `&dl=1` parameter 
        #                  replaced by `&dl=0`.
        # @raise [RuntimeError] If the file is not available within the specified 
        #                       maximum wait time, raises an error with a timeout message.
        #
        # @example
        #   wait_for_dropbox_url('/path/to/file', max_wait: 60, interval: 3)
        #   # => "https://www.dropbox.com/s/yourfile?dl=0"
        #
        def wait_for_dropbox_url(path, max_wait: 30, interval: 2)
            start_time = Time.now
          
            loop do
                begin
                    # Try to get the file URL
                    return BlackStack::DropBox.get_file_url(path).gsub('&dl=1', '&dl=0')
                rescue => e
                    # Check if the timeout has been exceeded
                    if Time.now - start_time > max_wait
                        raise "Timeout exceeded while waiting for Dropbox file (#{path}): #{e.message}"
                    end
            
                    # Wait for a short interval before retrying
                    sleep(interval)
                end
            end
        end

        # download image from Selenium using JavaScript and upload to Dropbox 
        # return the URL of the screenshot
        # 
        # Parameters:
        # - url: Internet address of the image to download from the website and upload to dropbox.
        # - dropbox_folder: Dropbox folder name to store the image.
        #                
        def download_image_0(url, dropbox_folder = nil)
            raise "Either dropbox_folder parameter or self.desc['id_account'] are required." if dropbox_folder.nil? && self.desc['id_account'].nil?
            dropbox_folder = self.desc['id_account'] if dropbox_folder.nil?
            
            # Parameters
            id = SecureRandom.uuid
            
            # JavaScript to get base64 image data
            js0 = "
                function getImageBase64(imageSrc) {
                return new Promise(async (resolve, reject) => {
                    try {
                    const response = await fetch(imageSrc);
                    const blob = await response.blob();
                    const reader = new FileReader();
                    reader.onloadend = function() {
                        resolve(reader.result);
                    };
                    reader.onerror = function(error) {
                        reject(error);
                    };
                    reader.readAsDataURL(blob);
                    } catch (error) {
                    reject(error);
                    }
                });
                }
                return getImageBase64('#{url}');
            "
            
            # Execute JavaScript and get base64 image data
            base64_image = driver.execute_script(js0)
            raise "Failed to retrieve image data from URL: #{url}" if base64_image.nil?
            
            # Extract MIME type and base64 data
            mime_type_match = base64_image.match(/^data:image\/([a-zA-Z0-9.+-]+);base64,/)
            if mime_type_match
                mime_subtype = mime_type_match[1] # e.g., 'png', 'jpeg', 'gif'
                # Map common MIME subtypes to file extensions
                extension = case mime_subtype
                            when 'jpeg' then 'jpg'
                            else mime_subtype
                            end
                # Remove the data URL prefix
                image_data = base64_image.sub(/^data:image\/[a-zA-Z0-9.+-]+;base64,/, '')
            else
                raise "Unsupported or invalid image data format."
            end
            
            # Update filename and paths
            filename = "#{id}.#{extension}"
            tmp_paths = if Mass.download_path.is_a?(String)
                            ["#{Mass.download_path}/#{filename}"]
                        elsif Mass.download_path.is_a?(Array)
                            Mass.download_path.map { |s| "#{s}/#{filename}" }
                        else
                            raise "Invalid Mass.download_path configuration."
                        end
            
            # Save the image to the first available path
            tmp_path = tmp_paths.find { |path| File.writable?(File.dirname(path)) }
            raise "No writable path found in #{tmp_paths.join(', ')}." if tmp_path.nil?
            
            File.open(tmp_path, 'wb') do |file|
                file.write(Base64.decode64(image_data))
            end
            
            # Proceed with Dropbox operations
            year = Time.now.year.to_s.rjust(4, '0')
            month = Time.now.month.to_s.rjust(2, '0')
            folder = "/massprospecting.rpa/#{dropbox_folder}.#{year}.#{month}"
            path = "#{folder}/#{filename}"
            BlackStack::DropBox.dropbox_create_folder(folder)
            
            # Upload the file to Dropbox
            BlackStack::DropBox.dropbox_upload_file(tmp_path, path)
            # Delete the local file
            File.delete(tmp_path)

            # Return the URL of the file in Dropbox
            # 
            # Add a timeout to wait the file is present in the cloud.
            # Reference: https://github.com/MassProspecting/docs/issues/320
            self.wait_for_dropbox_url(path).gsub('&dl=1', '&dl=0')
        end
                
        # download image from Selenium using JavaScript and upload to Dropbox 
        # return the URL of the screenshot
        # 
        # Parameters:
        # - img: Selenium image element to download from the website and upload to dropbox.
        # - dropbox_folder: Dropbox folder name to store the image.
        #
        def download_image(img, dropbox_folder=nil)
            download_image_0(img.attribute('src'), dropbox_folder)
        end # def download_image

        # take screenshot and upload it to dropbox
        # return the URL of the screenshot
        def screenshot(dropbox_folder=nil)
            raise "Either dropbox_folder parameter or self.desc['id_account'] are required." if dropbox_folder.nil? && self.desc['id_account'].nil?
            dropbox_folder = self.desc['id_account'] if dropbox_folder.nil?
            # parameters
            id = SecureRandom.uuid
            filename = "#{id}.png"
            tmp_path = "/tmp/#{filename}"
            # take screenshot using selenium driver and save it into the /tmp folder
            self.driver.save_screenshot(tmp_path)
            # code
            year = Time.now.year.to_s.rjust(4,'0')
            month = Time.now.month.to_s.rjust(2,'0')
            folder = "/massprospecting.rpa/#{dropbox_folder}.#{year}.#{month}"
            path = "#{folder}/#{filename}"
            BlackStack::DropBox.dropbox_create_folder(folder)
            BlackStack::DropBox.dropbox_upload_file(tmp_path, path)
            File.delete(tmp_path)
            BlackStack::DropBox.get_file_url(path).gsub('&dl=1', '&dl=0')
        end # def screenshot

        # create a file in the cloud with the HTML of the current page
        # return the URL of the file
        def snapshot(dropbox_folder=nil)
            raise "Either dropbox_folder parameter or self.desc['id_account'] are required." if dropbox_folder.nil? && self.desc['id_account'].nil?
            dropbox_folder = self.desc['id_account'] if dropbox_folder.nil?
            # parameters
            id = SecureRandom.uuid
            filename = "#{id}.html"
            tmp_path = "/tmp/#{filename}"
            # take screenshot using selenium driver and save it into the /tmp folder
            File.write(tmp_path, self.driver.page_source)
            # code
            year = Time.now.year.to_s.rjust(4,'0')
            month = Time.now.month.to_s.rjust(2,'0')
            folder = "/massprospecting.bots/#{dropbox_folder}.#{year}.#{month}"
            path = "#{folder}/#{filename}"
            BlackStack::DropBox.dropbox_create_folder(folder)
            BlackStack::DropBox.dropbox_upload_file(tmp_path, path)
            File.delete(tmp_path)
            BlackStack::DropBox.get_file_url(path).gsub('&dl=1', '&dl=0')
        end # def snapshot

        # return a selnium driver for this profile
        def driver()
            class_name = self.class.name.gsub('Mass::', '')
            allow_intercept_js = self.type.desc['allow_intercept_js']

            #l = BlackStack::DummyLogger.new(nil) if l.nil?

            c = AdsPowerClient.new(key: ADSPOWER_API_KEY)

            self.class.buffer_driver = nil if !c.check(self.desc['ads_power_id'])
            sleep(1)
            
            if self.class.buffer_driver.nil?
                self.class.buffer_driver = c.driver(self.desc['ads_power_id'], headless)
                self.class.buffer_driver.manage.window.resize_to(self.desc['browser_width'], self.desc['browser_height'])
                self.one_tab

                #if self.desc['allow_browser_to_download_multiple_files']
                #    self.automatic_downloads(status: :allow, domain: self.domain, secure: true, www: true)
                #else
                #    self.automatic_downloads(status: :block, domain: self.domain, secure: true, www: true)
                #end

                # Get source code of intercept.js library
                #l.logs "Getting source code of intercept.js library... "
                uri = URI.parse('https://raw.githubusercontent.com/leandrosardi/intercept/main/lib/intercept.js')
                js1 = Net::HTTP.get(uri)
                #l.logf "done".green
                

                # call ls command to get array of files in the folder
                # iterate all the *.js files inside the folder $RUBYLIB/extensions/mass.subaccount/js
                js2 = ''
                filenames = `ls #{Mass.js_path}/*.js`.split("\n")
                filenames.each { |filename|
                    # Get the source code of the scraper
                    js2 += `cat #{filename}`
                    js2 += "\n\n"
                }

                #l.logf "done".green + " (#{filename.blue})"

                # Initializing the interceptor
                js3 = ""
=begin
                js3 = "
                    $$.init({
                    parse: function(xhr) {
                        #{class_name}.scrape(xhr);
                    }
                    });
                "
=end            
                # Execute the scraper
                # Inject the library into the page
                #
                # Selenium: How to Inject/execute a Javascript in to a Page before loading/executing any other scripts of the page?
                #
                # Reference:
                # - https://stackoverflow.com/questions/31354352/selenium-how-to-inject-execute-a-javascript-in-to-a-page-before-loading-executi
                # 
                # Documentation:
                # - https://www.selenium.dev/documentation/webdriver/bidirectional/chrome_devtools/cdp_endpoint/
                #l.logs "Injecting the library into the page... "

                # setup a profile_type to work or not with intercept.js
                # References:
                # - https://github.com/VyMECO/mass.public/issues/6
                # - https://github.com/VyMECO/mass.public/issues/13
                #
                if allow_intercept_js
                    self.class.buffer_driver.execute_cdp("Page.addScriptToEvaluateOnNewDocument", source: js1+js2+js3)
                end
                #l.logf "done".green 
            end

            # return
            return self.class.buffer_driver
        end # def driver          

    end # class ProfileRPA
end # module Mass
