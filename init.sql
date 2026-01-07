```sql
CREATE DATABASE virtd;
CREATE USER 'app'@'localhost' IDENTIFIED BY 'QwErTy1234';
GRANT ALL PRIVILEGES ON example.* TO 'app'@'localhost';
FLUSH PRIVILEGES;
```