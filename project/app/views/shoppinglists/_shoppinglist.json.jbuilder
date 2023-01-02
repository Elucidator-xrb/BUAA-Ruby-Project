json.extract! shoppinglist, :id, :mtype, :total, :created_at, :updated_at
json.url shoppinglist_url(shoppinglist, format: :json)
