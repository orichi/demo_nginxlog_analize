class VectorCode < Nginxlog
  # attr_accessible :title, :body
  
  default_scope ->{limit(200)}
end
