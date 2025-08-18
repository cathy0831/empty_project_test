# frozen_string_literal: true

# Pagy initializer file (9.3.3)

# Pagy 預設設定
Pagy::DEFAULT[:limit]       = 10                    # default
Pagy::DEFAULT[:size]        = 7                     # default
Pagy::DEFAULT[:ends]        = true                  # default
Pagy::DEFAULT[:page_param]  = :page                 # default
# Pagy::DEFAULT[:count_args]  = []                    # example for non AR ORMs
# Pagy::DEFAULT[:max_pages]   = 3000                  # example

# 當超過最大頁面時，是否引發錯誤（預設 false）
# Pagy::DEFAULT[:overflow] = :empty_page

# 載入內建 i18n locale（zh-TW）
Pagy::I18n.load({ locale: "zh-TW" })

# 載入 extras
require "pagy/extras/array"

# 鎖定設定，避免後續被修改
Pagy::DEFAULT.freeze
