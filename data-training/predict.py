# run 'pip install pandas scikit-learn' to install them
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier

def make_pred(weight, cal_in, cal_out):

    # Load the CSV data set
    data = pd.read_csv('disease_data.csv')

    # Prepare the data
    X = data.iloc[:, 2:-1]  # Features (columns 2 to second-to-last)
    y = data.iloc[:, -1]    # Target variable (last column)

    # Encode categorical variables
    le = LabelEncoder()
    X_encoded = X.apply(le.fit_transform)

    # Split the data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X_encoded, y, test_size=0.2, random_state=42)

    # Train a Random Forest classifier
    clf = RandomForestClassifier(random_state=42)
    clf.fit(X_train, y_train)

    # Predict for person A with lung_cancer_data.csv
    # person_A = pd.DataFrame({'Age': [78],
    #                          'Gender': [2],
    #                          'Air Pollution': [8],
    #                          'Alcohol use': [8],
    #                          'Dust Allergy': [8],
    #                          'Occupational Hazards': [3],
    #                          'Genetic Risk': [2],
    #                          'Chronic Lung Disease': [8],
    #                          'Balanced Diet': [3],
    #                          'Obesity': [2],
    #                          'Smoking': [1],
    #                          'Passive Smoker': [2],
    #                          'Chest Pain': [8],
    #                          'Coughing of Blood': [8],
    #                          'Fatigue': [2],
    #                          'Weight Loss': [2],
    #                          'Shortness of Breath': [2],
    #                          'Wheezing': [1],
    #                          'Swallowing Difficulty': [8],
    #                          'Clubbing of Finger Nails': [4],
    #                          'Frequent Cold': [4],
    #                          'Dry Cough': [1],
    #                          'Snoring': [4]})



    # Predict for person A with disease_data.csv
    person_A = pd.DataFrame({
        'Age': [78],
        'Gender': [2],
        'Weight In Pounds': [weight],
        'Daily Calories Intake': [cal_in],
        'Daily Calories Outtake': [cal_out],
        'Alcohol Use': [9],
        'Smoking': [3],
        'Occupational Hazards': [5],
        'Chronic Disease': [8]
    })

    chance_prediction = clf.predict(person_A)[0]

    return chance_prediction