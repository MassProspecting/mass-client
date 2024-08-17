
![Gem version](https://img.shields.io/gem/v/mass-client) ![Gem downloads](https://img.shields.io/gem/dt/mass-client)

<img src="./assets/logo.svg" alt="image" width="256" height="auto" />

# Mass-Client

Ruby client for MassProspecting API

## Table of Contents

1. [Getting Started](#1-getting-started)

   1.1. [Install Ruby Gem of MassProspecting](#11-install-ruby-gem-of-massprospecting)

   1.2. [Setup the Client](#12-setup-the-client)

   1.3. [Create Tags for Your Leads and Companies](#13-create-tags-for-your-leads-and-companies)

   1.4. [Submit a Lead](#14-submit-a-lead)

   1.5. [Channels](#15-channels)

2. [CRM](#2-crm)

   2.1. [Submit a Company](#21-submit-a-company)

   2.2. [Assign Lead to a Company](#22-assign-lead-to-a-company)

   2.3. [Custom Data Fields](#23-custom-data-fields)

   2.4. [Industries](#24-industries)

   2.5. [Headcounts](#25-headcounts)

   2.6. [Revenues](#26-revenues)
   
3. [Advanded Client Setup](#3-advanded-client-setup)


## 1. Getting Started

Follow the steps below to submit your first lead.

### 1.1. Install Ruby Gem of MassProspecting

```bash
gem install mass-client
```

### 1.2. Setup the Client

1. Follow the steps in [this article](https://github.com/MassProspecting/docs/blob/main/api/1-getting-api-key.md) and get your MassProspecting API key.

2. Setup your MassProspecting client.

```ruby
require 'mass-client'

Mass.set(
    api_key: '4db9d88c-dee9-****-8d36-********',
)
```

### 1.3. Create Tags for Your Leads and Companies

Tags are a key part of **MassProspecting**.

Both, **leads** and **companies** can be tagged for further workflows configuration.

E.g.: You can setup an email campaign to be sent only to leads with a specific tag.

```ruby
Mass::Tag.upsert({ 
    'name' => 'testing', 
    'color_code' => :orange
})
```

### 1.4. Submit a Lead

```ruby
Mass::Lead.upsert({
    'first_name' => 'Leandro',
    'last_name' => 'Sardi',
    'middle_name' => 'Daniel',
    'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_100_100/0/1697551355295?e=1722470400&v=beta&t=2NZ4wUN2Cd9uzOuY0nrhWZOukpP84s3FPRFHNwOAZOs',
    'job_title' => 'Founder & CEO',
    'country' => 'Argentina',
    'timezone' => 'America/Argentina/Buenos_Aires',
    'email' => 'leandro@foo.com',
    'facebook' => 'https://www.facebook.com/leandro.sardi',
    'linkedin' => 'https://www.linkedin.com/in/leandro-daniel-sardi/',
    'tags' => ['testing'],
})
```

Note:

1. The picture of the lead will be download from the web and stored in a private repository of MassProspecting for furter reference.
If you call the `upsert` with a second time with the same value in `picture_url`, the operation of storing the image will be skipped.

2. If you call the `upsert` with a second time missing some fields (e.g.: `middle_name`), such a value won't be erased.
Only existing fields in the hash descriptions will be updated in the database.

3. The `upsert` operation tries to find an existing lead with the same id, email, linkedin or facebook.
The values of email, linkedin and facebook are normalized prior matching and storing operations.

4. Check the full [list of counties](/docu/countries.md) that you assign to a lead or company.

5. Check the full [list of timezones](/docu/timezones.md) that you can assign to a lead or company.

### 1.5. Channels

A **channel** is a 3th party service that you are using to grab information from, or performing an outreach.

**E.g.:**

- Facebook.
- LinkedIn.
- Apollo.
- Indeed.

**E.g.:** You are using LinkedIn, Facebook, Instagram for scraping leads and sending outreach too. You are using Apollo and FindyLeads for appending the email addresses of the Leads you scraped.

You can create a channel from its hash descriptor:

```ruby
Mass::Channel.upsert({ 
    'name' => 'linkedin', 
    'avatar_url' => 'https://images.rawpixel.com/image_trimmed_png_250/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjk4Mi1kNS0xMF8xLnBuZw.png', 
    'color_code' => :light_blue 
})
```

## 2. CRM

Some more feature to manage your leads are described in this chapter.

### 2.1. Submit a Company

```ruby
Mass::Company.upsert({
    'name' => 'VyMECO',
    'domain' => 'http://vymeco.com',
    'picture_url' => 'file://home/leandro/Downloads/logo.png',
    'country' => 'Uruguay',
    'timezone' => 'America/Argentina/Buenos_Aires',
    'tags' => ['testing'],  
    'sic' => ['9995', 100],
    'naics' => [112120, '1111A0'],
})
```

Note:

1. Unlike the previous examnple, this time the picture of the company company is taken from the local disk. 

2. The `upsert` operation tries to find an existing company with the same id, domain, linkedin, or facebook.
The values of domain, linkedin and facebook are normalized prior matching and storing operations.

3. Check the full [list of SIC codes](/docu/sic-codes.md) that you assign to a lead or company.

4. Check the full [list of NAICS codes](/docu/naics-codes.md) that you can assign to a lead or company.

### 2.2. Assign Lead to a Company

You can create/update both the lead and company in one single call, and assign the lead to such a company in the process.

```ruby
Mass::Lead.upsert({
    'first_name' => 'Leandro',
    'email' => 'leandro@foo.com',
    'company' => {
        'name' => 'VyMECO',
        'domain' => 'http://vymeco.com',
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/logo.png',
        'country' => 'Uruguay',
        'timezone' => 'America/Argentina/Buenos_Aires',
        'tags' => ['testing'],  
        'sic' => ['9995', 100],
        'naics' => [112120, '1111A0'],
    }
})
```

### 2.3. Custom Data Fields

You can create **custom data types** and create **custom attributes** for any lead and company.

```ruby
Mass::DataType.upsert({
    'name' => 'alternative_email',
    'type' => :string,
    # validate the format of the values assigned
    'format' => '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
})
```

You can setup `:integer` types too.

```ruby
Mass::DataType.upsert({
    'name' => 'number_of_locations',
    'type' => :integer,
    # validate the range of the value on each data record.
    'min_integer' => 0,
    'max_integer' => 10000,
})
```

You can setup `:float` types too.

```ruby
Mass::DataType.upsert({
    'name' => 'market_capitalization',
    'type' => :float,
    # validate the range of the value on each data record.
    'min_float' => 0.0,
    'max_float' => (500*1000*1000*1000).to_f,
})
```

Other types you can define are:

- `:boolean`, 
- `:date`, 
- `:time`, 
- `:text`

Assigning custom data to a lead is easy.

```ruby
Mass::Lead.upsert({
    'first_name' => 'Leandro',
    'email' => 'leandro@foo.com',
    'data' => [
        {'type' => 'alternative_email', 'value' => 'leandro@foo2.com'}
    ]
})
```

Assigning custom data to a company is similar.

```ruby
Mass::Company.upsert({
    'name' => 'VyMECO',
    'domain' => 'vymeco.com',
    'data' => [
        {'type' => 'number_of_locations', 'value' => 5},
        {'type' => 'market_capitalization', 'value' => 1000000000.0} # $1B :)
    ]
})
```

### 2.4. Industries

You can assign one or more industries to a company.

You can register an industry as follows:

```ruby
Mass::Industry.upsert({ 
    'name' => 'Financial Services', 
    'channel' => :linkedin,
})
```

Note that any industry is belonging a channel too. 
That makes sense when you scrape information from different sources (e.g.: LinkedIn, Apollo), and each source has its own list of values for such an attribute.

You can assign an industry to a company as follows:

```ruby
Mass::Company.upsert({
    'name' => 'VyMECO',
    'domain' => 'http://vymeco.com',
    'industry' => ['Financial Services'],
})
```

Note that you can assign more than one industry.

```ruby
Mass::Industry.upsert({ 
    'name' => 'Insurance', 
    'channel' => :linkedin,
})
```

```ruby
Mass::Company.upsert({
    'name' => 'VyMECO',
    'domain' => 'http://vymeco.com',
    'industry' => ['Financial Services', 'Insurance'],
})
```

### 2.5. Headcounts

You can register the headcounts managed by each differt channel.

```ruby
Mass::Headcount.upsert({ 
    'name' => '1 to 10 Employees', 
    'channel' => :linkedin,
    'min' => 1,
    'max' => 10
})
```

Then, you can assign a headcount to any company.

```ruby
Mass::Company.upsert({
    'name' => 'VyMECO',
    'domain' => 'http://vymeco.com',
    'headcount' => '1 to 10 Employees',
})
```

### 2.6. Revenues

You can register the headcounts managed by each differt channel.

```ruby
Mass::Revenue.upsert({ 
    'name' => 'From $1M to $10M per Year', 
    'channel' => :linkedin,
    'min' => 1000000,
    'max' => 10000000
})
```

Then, you can assign a headcount to any company.

```ruby
Mass::Company.upsert({
    'name' => 'VyMECO',
    'domain' => 'http://vymeco.com',
    'revenue' => 'From $1M to $10M per Year',
})
```

## 3. Advanded Client Setup

The **mass-client** accepts some custom configurations.

**Example:**

```ruby
Mass.set(
    # mandatory parameters
    api_key: '4cb865f4-fa4f-4c2f-8456-d366de44e13a',
    subaccount: 'MassProspecting',
    # connect to development environment
    api_url: 'http://127.0.0.1', 
    api_port: 3000,
    # optional parameters
    backtrace: true,
)
```

Here the full list of the parameters supported:

| Parameter      | Type            | Mandatory | Default Value                     | Description                                                                                           |
|----------------|-----------------|-----------|-----------------------------------|-------------------------------------------------------------------------------------------------------|
| `api_key`      | `String`        | Yes       | N/A                               | The API key of your MassProspecting account.                                                           |
| `subaccount`   | `String`        | Yes       | N/A                               | The name of the subaccount you want to work with.                                                      |
| `api_url`      | `String`        | No        | `'https://massprospecting.com'`    | The URL of the MassProspecting API.                                                                    |
| `api_port`     | `Integer`       | No        | `443`                             | The port of the MassProspecting API.                                                                   |
| `api_version`  | `String`        | No        | `'1.0'`                           | The version of the MassProspecting API.                                                                |
| `backtrace`    | `Boolean`       | No        | `false`                           | If `true`, the backtrace of the exceptions will be returned. If `false`, only an error description is returned. |
| `js_path`      | `String, nil`   | No        | `nil`                             | The path to the JavaScript file to be used by the SDK.                                                 |
| `download_path`| `String, Array` | No        | `[]`                              | The path to the download folder(s) to be used by the SDK. Must be a string or an array of strings.     |
