git clone https://github.com/InfraVsionary/Ecom.git

cd Ecom

DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1,0.0.0.0,SERVER_IP

docker compose up -d --build

docker compose exec web python manage.py migrate

docker compose exec web python manage.py collectstatic --noinput

docker compose exec web python manage.py createsuperuser


🌐 Access

App: http://SERVER_IP:8000/

Admin: http://SERVER_IP:8000/admin/
