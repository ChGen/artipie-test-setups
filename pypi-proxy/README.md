## How to use

```
./runDocker.sh
# ...

pip install --index-url http://localhost:8085/my-pypi --verbose --no-deps --trusted-host localhost alarmtime
rm -rfv ~/.local/lib/python3.10/site-packages/AlarmTime*
pip install --index-url http://localhost:8085/my-pypi --extra-index-url=http://localhost:8085/my-pypi --verbose alarmtime
rm -rfv ~/.local/lib/python3.10/site-packages/AlarmTime*
rm -rfv ~/.local/lib/python3.10/site-packages/DateTime*
```
