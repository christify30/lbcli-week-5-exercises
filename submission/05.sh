# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
blocks=150

block_hex=$(printf "%04x" "$blocks")
#little_endian=$(echo "$block_hex" | fold -w2 | tail -r | tr -d '\n') 
little_endian=$(echo "$block_hex" | sed -E 's/(..)(..)/\2\1/')
pubkey_hash=$(echo -n "$publicKey" | xxd -r -p | openssl sha256 -binary | openssl ripemd160 | awk '{print $2}')

script="02${little_endian}b27576a914${pubkey_hash}88ac"

echo "$script"
