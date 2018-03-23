# Multi page Feed Combiner

It's a Bash program which downloads and combines multi page feed files.

### Requirements

The computer that you will run this script needs to be able to run cURL command.

### How does it work?

Download the Bash script. A feed URL needs to be passed as an argument for the program to run. The feed URL must have the multi page feed macro included `{0}`. 

An example URL format that can be passed would be such as the following: 

`sh multipage.sh yourfeedurl_page{0}`

The program will download by the multi page feeds as long as cURL returns an HTTP Status Code 200.

#### Arguments

You can run the program with only 1 argument, that is, by just passing the multi page feed URL as shown above.

However, it can receive three arguments in total:

1. The feed URL *(mandatory)*
2. The directory path you want to download the feed files *(optional)*
3. The number of feed pages you want to download (i.e. 5 would mean the program will download all the feeds on pages 1...5, as long as pages are available) *(optional)*


##### Example use with 3 args:

`sh multipage.sh yourfeedurl_page{0} "C:\Users\b.kan\Desktop\google_product_multipage_feed" 5`

In this case it will download in the given path the first 5 pages of the feed.

You can also use it with 2 arguments, the 2nd argument being either the path argument or the the number of pages to download.


##### Example use with 2 args:


* `sh multipage.sh yourfeedurl_page{0} "C:\Users\b.kan\Desktop\google_product_multipage_feed"`

	In this scenario, all the available feed files will be downloaded in the given path.

* `sh multipage.sh yourfeedurl_page{0} 10`
	
    In this scenario, the first 10 available pages will be downloaded as long as the HTTP Status Code for these files are returned 200. 
    
    If the path is not given as an argument, the program will create a *multipage_feed* directory in the current working directory and 	the files will be downloaded in that directory.
    
