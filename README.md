# X Cyber Squad – AIOSEO WordPress API Enumeration Tool

## 🛠 Description
This is an API enumeration tool for identifying `aioseo/v1` REST endpoints in WordPress-based websites.

Used for reconnaissance, VAPT, and bug bounty automation.

## 🧰 Features
- Finds all AIOSEO plugin endpoints
- Tests accessibility: Public, Unauthorized, Forbidden, Not Found
- Saves output to timestamped `.txt` file
- Designed for use in digital forensics & pentest engagements

## 💻 Usage

```bash
chmod +x xcs-aioseo-enum.sh
./xcs-aioseo-enum.sh https://target-wordpress-site.com
```

## 📤 Output Example

[200] https://target.com/wp-json/aioseo/v1/seo-analysis/homeresults -> 200 OK
[401] https://target.com/wp-json/aioseo/v1/pagespeed -> 401 Unauthorized

## 👨‍💻 Author

**Neerav Patel**  
Cyber Expert and Forensic Investigator and Crime Investigator

## 📝 License
Open-source under MIT License
