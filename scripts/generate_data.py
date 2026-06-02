# This script generates synthetic customer data for an e-commerce analytics project.
# It uses the Faker library to create realistic customer names, emails, and cities.
#But it is not effective. DO NOT USE THIS
import pandas as pd
from faker import Faker


# Initialize Faker with the Indian locale
fake = Faker('en_IN')


# Set seed for reproducible results (optional)
Faker.seed(42)

# Generate 1000 customer records
data = []
for _ in range(1000):
    first_name = fake.first_name()
    last_name = fake.last_name()
    # Create a simple email from the name
    email = f"{first_name.lower()}.{last_name.lower()}@example.com"
    
    data.append({
        'Name': first_name+' '+last_name,
        'Email': email,
        'City': fake.city() # Generates realistic Indian cities/towns
    })

# Convert to a DataFrame and save to CSV
df = pd.DataFrame(data)
df.to_csv('data/customers.csv', index=False)

print("1000 customer records successfully generated and saved to 'data/customers.csv'!")
print(df.head())

