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
### Sheet
This application utilizes a single Google Sheet document which stores the student form responses. If the form/sheet changes, the `SHEET_ID` in the `.env` file will need to change.

The Google Drive Sheet needs to be published to be publicly accessible by the API which serves up JSON. From the Sheet itself in Google Drive, Choose: File -> Publish To The Web

### Classes
For the two-class model, we have two `.env` variables, one for each class. Update the `CLASS_ONE` and `CLASS_TWO` variable names to correspond to each class name. This name should also correspond to the class name in the form to appropriate filter student responses.

## Deployment
This application uses a single `rake` task to read the Sheet and update the database entries if there are recent changes (based on a timestamp). To run this task locally, use `rake sheets:update`.

When deploying this application, it is best to set up a job to run this rake task at a regular interval (~1x/hour). Easy setup instructions are located [here](https://devcenter.heroku.com/articles/scheduler).
