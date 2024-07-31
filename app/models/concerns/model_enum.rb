class ModelEnum
  extend ActiveSupport::Concern

  def self.data_states_enum
    {
      disable: 0,
      add: 1,
      enable: 100,
      default: 200,
      system: 300,
    }
  end
end
