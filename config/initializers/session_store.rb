# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hbci4rails_session',
  :secret      => '2fc33ec23d9377c73a3f653427f0fcd93ecb3fadc3590f4dc572af186b70d39fafe1d5ac69c30625d47b5bb5af009a68254f22fe664cd2c8d78beeb56b9cf719'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
