## 生管系統

### 資料庫設計
  
  [ERD]()

### 相關文件

  #### 系統需求規格書

  現行版本: 
  [v1.0]()
  
  #### 系統開發規格書
  現行版本:
  [v1.0]()

  #### 前端測試表單
  現行版本:
  [v1.0]()
  
  #### 使用手冊

  現行版本: 

### 安裝指南
 
  #### 系統版本
  ```
  ruby 3.1.4
  rails 7.1.2
  node v16.16
  ```
  #### 使用套件
  ```
  # FrontEnd
  vite 4.5.1
  vite-plugin-ruby 5.0
  vue2 1.0
  tailwindcss 3.3.5

  # BackEnd
  mysql2
  activerecord-sqlserver-adapter
  tiny_tds
  wicked_pdf
  ```
  #### 環境參數
  ```
  # credentials/[enviroment].yml.enc
  # 系統 資料庫
  DB_HOST: ""
  DB_PORT: ""
  DB_USER: ""
  DB_PASSWORD: ""
  DB_NAME: ""
  
  # SMTP
  SMTP_DOMAIN: ""  
  SMTP_USER: ""  
  SMTP_PASSWORD: ""

  # 伺服器
  SERVER_HOST: ""
  SERVER_PORT: "" 

  # Exception
  EXCEPTION_NAME: ""
  EXCEPTION_RECIPIENT: ""
  SLACK_WEBHOOK: ""
  SLACK_CHANNEL: ""

  ```

<details>
  <summary>開發說明</summary>
  
  ##### 環境參數
  ```
  # credentials/development.key
  daee001b904abd6bb84c21a07ad5b252
  ```
  ##### 常用指令
  * 啟動專案: `$ bundle exec foreman start -f Procfile.dev -p [PORT] `
  * 啟動專案(執行腳本): ./bin/dev [PORT]`
  * 重建資料庫: `$ rails dev_func:rebuild`
  * 程式碼樣式檢查: `$ rails dev_func:check_style`
  * 程式碼掃描檢查: `$ rails dev_func:code_analysis`
  * 編輯開發環境參數: `$ rails credentials:edit --environment development`
  
</details>
<details>
  <summary>自動化測試說明</summary>
  
  ##### 環境參數
  ```
  # credentials/test.key
  09d9ffcd1f2ae46a9b1427fff76e8fc4
  ```

  ##### 常用指令
  * 程式碼自動化測試: `$ rails dev_func:test_app`
</details>
<details>
  <summary>測試說明</summary>
  
  ##### 測試伺服器
  IP: TODO

  資料庫: TODO 

  ##### 環境參數
  ```
  # credentials/staging.key
  TODO
  ```
</details>
<details>
  <summary>發布說明</summary>

  ##### 發布伺服器
  IP: TODO

  資料庫: TODO


  ##### 環境參數
  ```
  # credentials/production.key
  TODO
  ```

  ##### 注意事項

</details>