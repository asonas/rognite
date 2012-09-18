class Log < ActiveRecord::Base
  attr_accessible :body, :project_id, :user_id
end
