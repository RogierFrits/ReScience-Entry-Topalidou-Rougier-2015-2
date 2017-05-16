FROM topalidou-rougier-2015-base
LABEL maintainer "rogier.mars@student.vu.nl"

# Create WORKDIR
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy project code to WORKDIR
COPY code/ .

# Compile project
RUN python setup.py build_ext --inplace
