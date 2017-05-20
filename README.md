# API

An API for Charlotte Junior Devs.

## REST interface

### Events

```
GET /events
```

#### Creating New Events
```
POST /events

{
  event: {
    category: "credit name goes here",
    user_id:  user_id,
    info:     {
      whatever: "can go here",
      etc:      "etc",
    }
  }
}

```

### Recommendations

```
GET /credibility
```

## Authentication
All requests must have an `Authorization` http header with `Bearer <your-token-here>`.


<hr>
*for development environment only*

The bearer token is a JSON Web Token and can be easily generated by running:
```sh
rake token
```

Or, pipe it directly to your clipboard:

```sh
rake token | pbcopy
```

###Creating your .env file

1. In the ROOT file of your directory (/api) create a new text file called ".env"

2. In your terminal, run the following command to copy the contents of the .env.sample file to your own .env file:
```sh
 cp .env.sample .env
 ```

3. Go to the following link to generate an API token on GitHub:

https://github.com/settings/tokens

*When generating your token, give a brief description of what the token is for, but leave the options for scopes blanks.

4. Fill in the value in your .env file with the token that was generated.
```sh 
GITHUB_API_TOKEN=<the-token-generated-from-github>
```


