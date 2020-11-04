# Medical Database

## Project Description

## Project Name: MedHelp 
### Team Members: Yinan Guo, Saurav Sawansukha, Jordan Auerbach, Haoyang Chen

#### The problem we want to solve:

In the US, drug prices can differ significantly at different pharmacies. According to a report posted by Dr Patel on PharmacyChecker.com, “the generic version of the cholesterol drug Lipitor, called atorvastatin, can cost $9 at a Walmart in a town, but $226 at the local Walgreens.”(Patel, 2019) Wanting to give people the ability to see if they are overcharged, we decided to build a system called MedHelp.

#### Business space 

The brainstorming session held for the past two weeks gave us time to think and reflect on what specific topic to tackle and who is the target audience of our database. This database is targeting patients or families living in America who want to have more awareness and knowledge of their medication that will help save them money, find medication based on symptoms and stay up to date with their prescriptions. Furthermore, the implementation of the database will be more in-depth with key properties conveyed to the audience with information such as: where to get prescription based medication, medications over the counter, and keep track of personal medication for individuals or families. Personally, from our perspective, we will need to use various sets of data and APIs that give us large volumes of data to make comparisons and several types of medication to cater to our clients.  

#### Typical users  

Because our database is mainly targeting people who seek medical help, we identify that our regular users include American families, individuals, and caretakers who aim at saving money, looking up their prescriptions, and finding medications based on their symptoms.

#### Decisions of Users

Based on the data in the database, the users will be able to find the cheapest place to get their prescriptions and will be able to input their symptoms to find out what kind of medicine they might need. They will have to power to scroll through the database to find what medication they need, and then will be shown all of the options of where to get said medicine in their area. To know where the user lives, the user will have the decision to input their area code or city. Then, our app will scan through our database to find all of the local pharmacies in their area, within whatever radius limit the input. Also, the user will be able to input reminders for when they need to refill their prescription, and our app will notify them when it is time to refill.

#### Final SQL code contains

* 8 stored procedures to populate transactional tables
* Definition of 8 business rules
* 8 user-defined function to enforce the business rule defined above 
* 8 user-defined function to enable a computed column
* 8 view generating a 'complex' query (includes multiple JOINs, GROUP BY/HAVING statements, and aggregate function)

#### Reference
Patel, S. (2019, February 12). Why are drug prices so different at different pharmacies? Retrieved from https://www.pharmacychecker.com/askpc/different-drug-prices-different-pharmacies/.