class Authentication < ActiveRecord::Base
  belongs_to :user
  
  def provider_name  
    if provider == 'google_apps'  
      "Google"  
    else  
      provider.titleize  
    end  
  end
  
end
