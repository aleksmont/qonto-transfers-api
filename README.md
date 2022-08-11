# Aleksander Monteiro - Qonto Coding Challenge

This README would normally document whatever steps are necessary to get the
application up and running.

To install the project:

`Install Ruby v3.0.0 and bundler v2.3.19`

Then just run `bundle install on the root directory`

To run the tests:

`bundle exec rspec`

This project have just 1 endpoint: /transactions
You can use this endpoint with any application or postman...
use the request body JSON like this example:

```
{
    "organization_name": "ACME Corp",
    "organization_bic": "OIVUSCLQXXX",
    "organization_iban": "FR10474608000002006107XXXXX",
    "credit_transfers": [
        {
        "amount": "14.5",
        "currency": "EUR",
        "counterparty_name": "Bip Bip",
        "counterparty_bic": "CRLYFRPPTOU",
        "counterparty_iban": "EE383680981021245685",
        "description": "Wonderland/4410"
        }
    ]
}
```

Notes:
I used the 3 hours recommendation for this project. So there are some thing that I would like to improve:

- Implement rswag gem, for the swagger documentation.
- Make more validations in the controller and the services.
- Create a dockerfile to run the application and run the tests.