## A GPT Chat bot based on specific knowledge

# Setup
You will need postgres with pgvector.
`docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres --name knowledge_based_gpt_postgres ankane/pgvector`

Then setup the Rails application
`bundle install`
`rails db:create; rails db:migrate`

You need to have knowledge in the text_items table for the GPT model to use.

`db/seeds.rb` Contains logic to seed book details with the following structure:
```
#Chapter <Chapter name>
##<Section name>

You need to number at least the first paragraph like this:
1. Here is my first paragraph.

Here is my second paragraph.
```
