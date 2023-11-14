# Use Python 3.6 as a base image
# Copy contents into image
# Install pip dependencies from requirements
# Set YOUR_NAME environment variable
# Expose the correct port
# Create an entrypoint


FROM python:3.6

WORKDIR /app

COPY . .

RUN pip3 install -r requirements.txt

EXPOSE 5500

ENV YOUR_NAME="Sathish"

ENTRYPOINT [ "python", "app.py" ]