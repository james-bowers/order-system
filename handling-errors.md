# Thoughts on handling errors.

- When should a request's data be validated?

1. Validated in the web layer?

pros:

- Bad requests stopped early
- More control over error messages
- Not case matching back to the model layer to handle errors.
- Business layer kept lightweight

cons:

- throwing and catching errors? (using ! in db transactions?)

2. Go through to the Repo changeset validator?
