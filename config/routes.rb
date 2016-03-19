Rails.application.routes.draw do
  root 'home#index'                                                       # Root (Index Page)

  # Dashboard Routes
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'                 # Display Dashboard

  # User Routes
  get 'signup', to: 'users#new', as: 'signup'                             # Display Signup Form
  post 'signup', to: 'users#create'                                       # Process Signup Form

  # Session Routes
  get 'login', to: 'sessions#new', as: 'login'                            # Display Login Form
  post 'login', to: 'sessions#create'                                     # Process Login Form
  get 'logout', to: 'sessions#destroy', as: 'logout'                      # Process Logout

  # Password Reset Routes
  get 'forgot', to: 'password_resets#new', as: 'forgot'                   # Display Forgot Form
  post 'forgot', to: 'password_resets#create'                             # Process Forgot Form
  get 'reset', to: 'password_resets#edit', as: 'reset'                    # Display Reset Form
  post 'reset', to: 'password_resets#edit'                                # Process Reset Form

  # Home Routes
  get 'about', to: 'home#about', as: 'about'                              # About Page
  get 'contact', to: 'home#contact', as: 'contact'                        # Contact Page
  get 'faq', to: 'home#faq', as: 'faq'                                    # FAQ Page
  get 'terms', to: 'home#terms', as: 'terms'                              # Terms Page
  get 'privacy', to: 'home#privacy', as: 'privacy'                        # Privacy Page

  # Profile Routes
  get 'profile/:id', to: 'profiles#show', as: 'profile'
  get 'profile/:id/connections', to: 'profiles#show', as: 'connections'
  get 'profile/:id/connections/received', to: 'profiles#show', as: 'received_requests'
  get 'profile/:id/connections/sent', to: 'profiles#show', as: 'sent_requests'

  # Connection Routes
  get 'profile(/:id/)connect', to: 'friendships#connect', as: 'connect'
  get 'profile(/:id/)cancel', to: 'friendships#cancel', as: 'cancel'
  get 'profile(/:id/)accept', to: 'friendships#accept', as: 'accept'
  get 'profile(/:id/)decline', to: 'friendships#decline', as: 'decline'
  get 'profile(/:id/)disconnect', to: 'friendships#disconnect', as: 'disconnect'

  # Setting Routes
  get 'settings/profile', to: 'profiles#edit', as: 'profile_settings'
  post 'settings/profile', to: 'profiles#update'
  get 'settings/password', to: 'profiles#edit', as: 'password_settings'
  post 'settings/password', to: 'profiles#update'
  get 'settings/account', to: 'profiles#edit', as: 'account_settings'
  post 'settings/account', to: 'profiles#update'

  # Messages Routes
  get 'messages/new', to: 'messages#new', as: 'new_message'

  get 'messages', to: 'messages#index', as: 'message'
  get 'messages/:id', to: 'messages#index', as: 'messages'
  post 'messages/:id', to: 'messages#create'

  # Books Routes
  get 'books', to: 'books#index', as: 'books'

  get 'books/new', to: 'books#new', as: 'new_book'
  post 'books/new', to: 'books#create'

  get 'books/:id', to: 'books#show', as: 'book'

  get 'books/:id/edit', to: 'books#edit', as: 'edit_book'
  post 'books/:id/edit', to: 'books#update'

  get 'books/:id/delete', to: 'books#destroy', as: 'delete_book'

  get 'books/category/:category', to: 'books#index', as: 'books_category'

  get 'books/:id/update', to: 'books#update_date', as: 'update_book_date'

  # Roommates Routes
  get 'roommates', to: 'roommates#index', as: 'roommates'

  get 'roommates/new', to: 'roommates#new', as: 'new_roommate'
  post 'roommates/new', to: 'roommates#create'

  get 'roommates/:id', to: 'roommates#show', as: 'roommate'

  get 'roommates/:id/edit', to: 'roommates#edit', as: 'edit_roommates'
  post 'roommates/:id/edit', to: 'roommates#update'

  get 'roommates/:id/delete', to: 'roommates#destroy', as: 'delete_roommates'

  # get 'roommates/category/:category', to: 'roommates#index', as: 'roommates_category'

  get 'roommates/:id/update', to: 'roommates#update_date', as: 'update_roommates_date'
end
