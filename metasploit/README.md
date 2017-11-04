# Metasploit

Images containing the metasploit framework

## Example Usage

### Standalone

```
docker run -it --rm joelnb/metasploit
```

### With postgresql

The sleep in this example just allows postresql to fully become ready before trying to connect.

```
docker run --name metasploit-db -e POSTGRES_PASSWORD=postgres -d postgres
sleep 10
docker run --name metasploit -it --rm --link metasploit-db:db -e MSFDBHOST=db joelnb/metasploit
```
