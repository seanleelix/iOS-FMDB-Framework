# iOS-FMDB-Framework
iOS FMDB Framework with Android Style

1.$pod init  
2.edit podfile -> pod 'FMDB/SQLCipher'  
3.$pod install  

Why I created this?  
我為什麼弄了這個framework？  

Because FMDB is not so easy to control, especially for android programer.  
對於Android程序員來說，也许FMDB不太好使用。  

1.添加方法到DatabaseOperation中  
2.得到一個 DatabaseOperation Instance  
DatabaseOperation *databaseOperation = [[DatabaseOperation alloc] init];  
3.通過操作operation來操作數據庫
[databaseOperation addPersonWithName:@"name" height:1.7f];  

註：若使用sqlcipher， 則在DatabaseConstants中取消註釋 DATABASE_SECRET_KEY 並設置password
