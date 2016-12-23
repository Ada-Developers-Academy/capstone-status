# Capstone Status
This application manages student capstone status information for instructors.

## Installation
```
gem install bundler
bundle install
# Run Postgres
rake db:create
rake db:migrate
```

## Configuration
This application utilizes a single Google Drive Sheet which stores to student form responses. When the form or the shet which stores the results change, the `SHEET_ID` in the `.env` file will need to change.
Note: The Google Drive Sheet needs to be published to be publicly accessible by the API which serves up JSON. (File -> Publish To The Web)
