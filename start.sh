docker build --tag=ppmtest .
docker run -p 8080:8080 ppmtest:latest 
