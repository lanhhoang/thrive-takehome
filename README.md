# Thrive Take Home Challenge

# Description

- The challenge can be solved using many approaches and I chose the model first approach to encapsulate the business logic as below in `User` and `Company` models and make the code self-explanatory.

  > Any user that belongs to a company in the companies file and is active
  > needs to get a token top up of the specified amount in the companies top up field.

  > If the users company email status is true indicate in the output that the user was sent an email (don't actually send any emails).
  > However, if the user has an email status of false, don't send the email regardless of the company's email status.

  ![Flow Chart](/docs/flowchart.svg)

- In larger codebase, three methods including `import_json`, `parse_int`, and `export` can be extracted to separated modules to follow Separation of Concerns principle. However, in the context of this challenge, because they are used in one place, so I placed them in `InputReader` and `CompanyDataExporter` modules.

# How to run

## Prerequisites

- Install Ruby version `3.3.5`

## Code

- Run the code file located in the `bin` folder

```sh
ruby bin/challenge.rb
```

- The `output.txt` is saved in the `output` folder

## Spec

- Install gems

```sh
bundle install
```

- Run spec

```sh
bundle exec rspec spec/
```
