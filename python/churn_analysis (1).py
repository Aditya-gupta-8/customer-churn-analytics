# Customer Churn Analytics
import pandas as pd
import matplotlib.pyplot as plt
df = pd.read_csv("../data/customer_churn.csv", parse_dates=["signup_date","last_login"])
print(df.info())
print("Churn rate:", round(df.churn.eq("Yes").mean()*100,2), "%")

for col, title in [("contract_type","Churn Rate by Contract Type"),
                   ("plan","Churn Rate by Subscription Plan"),
                   ("region","Churn Rate by Region")]:
    x=df.groupby(col).churn.apply(lambda s:(s=="Yes").mean()*100).sort_values(ascending=False)
    print("\n",x)
    plt.figure(figsize=(8,5)); x.plot(kind="bar"); plt.title(title)
    plt.ylabel("Churn Rate (%)"); plt.xticks(rotation=0); plt.tight_layout(); plt.show()

sat=df.groupby("satisfaction_score").churn.apply(lambda s:(s=="Yes").mean()*100)
plt.figure(figsize=(8,5)); sat.plot(marker="o")
plt.title("Satisfaction Score vs Churn Rate"); plt.xlabel("Satisfaction Score")
plt.ylabel("Churn Rate (%)"); plt.tight_layout(); plt.show()

ticket=df.assign(group=df.support_tickets.ge(4).map({True:"4+ tickets",False:"0-3 tickets"}))
x=ticket.groupby("group").churn.apply(lambda s:(s=="Yes").mean()*100)
plt.figure(figsize=(8,5)); x.plot(kind="bar"); plt.title("Support Tickets vs Churn")
plt.ylabel("Churn Rate (%)"); plt.xticks(rotation=0); plt.tight_layout(); plt.show()

churned=df[df.churn=="Yes"]
print("Monthly revenue at risk:", round(churned.monthly_charges.sum(),2))
print("Annualized revenue at risk:", round(churned.monthly_charges.sum()*12,2))
