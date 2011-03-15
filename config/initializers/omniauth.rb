require 'openid/store/filesystem'

if Rails.env == "production"
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, 'PyXZXQKyIDn1UDf0EQw2A', 'LZnUKAfUr7A45rJIQJ0iKzohuwgZM26kDdGCPREOZEE'
    provider :facebook, '189629141074242', '1d9436f172bb1f057fa19199da5dc24a'  
    provider :google_apps, OpenID::Store::Filesystem.new('./tmp'), :domain => 'gmail.com', :name => 'google'
  end 
else
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, 'PyXZXQKyIDn1UDf0EQw2A', 'LZnUKAfUr7A45rJIQJ0iKzohuwgZM26kDdGCPREOZEE'
    provider :facebook, '118085544932814', '92314eb527229ce131d8b8fa2ada8345'
    provider :google_apps, OpenID::Store::Filesystem.new('/tmp'), :domain => 'gmail.com', :name => 'google'
  end 
end