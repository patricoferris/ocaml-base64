
let encoded = [
  "helloworld", "NBSWY3DPO5XXE3DE"
]

let rfc4648_base32 = [
  "", "";
  "f", "MY======";
  "fo", "MZXQ====";
  "foo", "MZXW6===";
  "foob", "MZXW6YQ=";
  "fooba", "MZXW6YTB";
  "foobar", "MZXW6YTBOI======";
]

let rfc4648_base32hex = [
   "", "";
  "f", "CO======";
  "fo", "CPNG====";
  "foo", "CPNMU===";
  "foob", "CPNMUOG=";
  "fooba", "CPNMUOJ1";
  "foobar", "CPNMUOJ1E8======"
]

let tests_encode ?(alphabet = Base32.default_alphabet) input output () =
  let actual = Base32.encode_exn ~alphabet ~pad:true input in 
  Alcotest.(check string) "same string" output actual

let encoding_test = 
  List.map (fun (i, o) -> Alcotest.test_case i `Quick (tests_encode i o)) encoded

let encoding_rfc = 
  List.map (fun (i, o) -> Alcotest.test_case i `Quick (tests_encode i o)) rfc4648_base32
  
let encoding_hex = 
  List.map (fun (i, o) -> Alcotest.test_case i `Quick (tests_encode ~alphabet:Base32.extended_hex i o)) rfc4648_base32hex
  
  

let () =
  Alcotest.run "Base32" [ ("encode", encoding_test); ("encode32", encoding_rfc); ("encode32hex", encoding_hex) ]