NODENAME = 'n01'

# Setup parameters to connect your MassProspecting API
BlackStack::API.set_client(
    api_key: '<place your MassProspecting API Key here>',
    api_url: BlackStack.sandbox? ? 'http://127.0.0.1' : 'https://' + NODENAME + '.massprospecting.com',
    api_port: BlackStack.sandbox? ? 3000 : 443,
    api_version: '1.0'
)
