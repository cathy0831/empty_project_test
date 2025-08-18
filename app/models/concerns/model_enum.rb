class ModelEnum
  extend ActiveSupport::Concern

  def self.data_state_enum
    {
      disable: 0,
      add: 1,
      enable: 100,
      default: 200,
      system: 300,
    }
  end

  def self.permission_state_enum
    {
      disable: 0,
      enable: 100,
      default: 200,
      system: 300,
    }
  end

  def self.user_state_enum
    {
      disable: 0,
      enable: 100,
      system: 300,
    }
  end
end
