# Thrive Take Home Challenge

# Description

- The challenge can be solved using many approaches and I chose the model first approach to encapsulate the business logic as below in `User` and `Company` models and make the code self-explanatory.

  > Any user that belongs to a company in the companies file and is active
  > needs to get a token top up of the specified amount in the companies top up field.

  > If the users company email status is true indicate in the output that the user was sent an email (don't actually send any emails).
  > However, if the user has an email status of false, don't send the email regardless of the company's email status.

  [![](https://mermaid.ink/img/pako:eNqNkU1TgzAQhv_KTs60Q8pnOejY0g9n1IN4seAhQkqZQsJAUCvlvxsotuJFc8ruvu8-u0mNQh5R5KBtyt_DHSkE3D0GDOS58T0h4xcYja5gVrucllCVtIBXmnIWg-BAIORZTtjhujl5Zq34-EzLI8zr215PQpG80aHkgR9h4y9Y9HLKzi9G13_iOVS5BOwpG9R_u9xutkVL6gcBmpEkhVIQUZUgiurMXVwIq_Nof6hb3tL39kkOJWVRIrfuHD1-2eF_DrS6QNa-Jy0D_eo_TdeDpkhBGS1kOZJ_VLeKAIkdzWiAHHmNSLEPUMAaqSOV4N6BhchpF1FQlUdEUDchcUGy7ySNEsGL-9Ofh5xtk1ha5cshp0YfyBlhXR2rmq1PpyY2NANPDQUdkIO1yRjbE13FpqVhU7OtRkGfnMvGeIx107DUiWqYtq1bptk13HTFLUlLiS14Fe_6qPkCXOTCNw?type=png)](https://mermaid.live/edit#pako:eNqNkU1TgzAQhv_KTs60Q8pnOejY0g9n1IN4seAhQkqZQsJAUCvlvxsotuJFc8ruvu8-u0mNQh5R5KBtyt_DHSkE3D0GDOS58T0h4xcYja5gVrucllCVtIBXmnIWg-BAIORZTtjhujl5Zq34-EzLI8zr215PQpG80aHkgR9h4y9Y9HLKzi9G13_iOVS5BOwpG9R_u9xutkVL6gcBmpEkhVIQUZUgiurMXVwIq_Nof6hb3tL39kkOJWVRIrfuHD1-2eF_DrS6QNa-Jy0D_eo_TdeDpkhBGS1kOZJ_VLeKAIkdzWiAHHmNSLEPUMAaqSOV4N6BhchpF1FQlUdEUDchcUGy7ySNEsGL-9Ofh5xtk1ha5cshp0YfyBlhXR2rmq1PpyY2NANPDQUdkIO1yRjbE13FpqVhU7OtRkGfnMvGeIx107DUiWqYtq1bptk13HTFLUlLiS14Fe_6qPkCXOTCNw)

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
