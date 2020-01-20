[System.Math]::Abs(-10)

#:: means accessing a static member

[Math]::Pi

[System.Net.Dns]::GetHostAddresses('bing.com')


# Instance Member

#$web = New-Object -TypeName System.Net.WebRequest

$web = [System.Net.WebRequest]::Create('http://www.criticalsolutions.net')
$web | gm

<#
   TypeName: System.Net.HttpWebRequest

Name                                 MemberType Definition
----                                 ---------- ----------
Abort                                Method     void Abort()
AddRange                             Method     void AddRange(int from, int to), void AddRange(long from, long to), void AddRange(i...
BeginGetRequestStream                Method     System.IAsyncResult BeginGetRequestStream(System.AsyncCallback callback, System.Obj...
BeginGetResponse                     Method     System.IAsyncResult BeginGetResponse(System.AsyncCallback callback, System.Object s...
CreateObjRef                         Method     System.Runtime.Remoting.ObjRef CreateObjRef(type requestedType)
EndGetRequestStream                  Method     System.IO.Stream EndGetRequestStream(System.IAsyncResult asyncResult), System.IO.St...
EndGetResponse                       Method     System.Net.WebResponse EndGetResponse(System.IAsyncResult asyncResult)
Equals                               Method     bool Equals(System.Object obj)
GetHashCode                          Method     int GetHashCode()
GetLifetimeService                   Method     System.Object GetLifetimeService()
GetObjectData                        Method     void ISerializable.GetObjectData(System.Runtime.Serialization.SerializationInfo inf...
GetRequestStream                     Method     System.IO.Stream GetRequestStream(), System.IO.Stream GetRequestStream([ref] System...
GetRequestStreamAsync                Method     System.Threading.Tasks.Task[System.IO.Stream] GetRequestStreamAsync()
GetResponse                          Method     System.Net.WebResponse GetResponse()
GetResponseAsync                     Method     System.Threading.Tasks.Task[System.Net.WebResponse] GetResponseAsync()
GetType                              Method     type GetType()
InitializeLifetimeService            Method     System.Object InitializeLifetimeService()
ToString                             Method     string ToString()
Accept                               Property   string Accept {get;set;}
Address                              Property   uri Address {get;}
AllowAutoRedirect                    Property   bool AllowAutoRedirect {get;set;}
AllowReadStreamBuffering             Property   bool AllowReadStreamBuffering {get;set;}
AllowWriteStreamBuffering            Property   bool AllowWriteStreamBuffering {get;set;}
AuthenticationLevel                  Property   System.Net.Security.AuthenticationLevel AuthenticationLevel {get;set;}
AutomaticDecompression               Property   System.Net.DecompressionMethods AutomaticDecompression {get;set;}
CachePolicy                          Property   System.Net.Cache.RequestCachePolicy CachePolicy {get;set;}
ClientCertificates                   Property   System.Security.Cryptography.X509Certificates.X509CertificateCollection ClientCerti...
Connection                           Property   string Connection {get;set;}
ConnectionGroupName                  Property   string ConnectionGroupName {get;set;}
ContentLength                        Property   long ContentLength {get;set;}
ContentType                          Property   string ContentType {get;set;}
ContinueDelegate                     Property   System.Net.HttpContinueDelegate ContinueDelegate {get;set;}
ContinueTimeout                      Property   int ContinueTimeout {get;set;}
CookieContainer                      Property   System.Net.CookieContainer CookieContainer {get;set;}
CreatorInstance                      Property   System.Net.IWebRequestCreate CreatorInstance {get;}
Credentials                          Property   System.Net.ICredentials Credentials {get;set;}
Date                                 Property   datetime Date {get;set;}
Expect                               Property   string Expect {get;set;}
HaveResponse                         Property   bool HaveResponse {get;}
Headers                              Property   System.Net.WebHeaderCollection Headers {get;set;}
Host                                 Property   string Host {get;set;}
IfModifiedSince                      Property   datetime IfModifiedSince {get;set;}
ImpersonationLevel                   Property   System.Security.Principal.TokenImpersonationLevel ImpersonationLevel {get;set;}
KeepAlive                            Property   bool KeepAlive {get;set;}
MaximumAutomaticRedirections         Property   int MaximumAutomaticRedirections {get;set;}
MaximumResponseHeadersLength         Property   int MaximumResponseHeadersLength {get;set;}
MediaType                            Property   string MediaType {get;set;}
Method                               Property   string Method {get;set;}
Pipelined                            Property   bool Pipelined {get;set;}
PreAuthenticate                      Property   bool PreAuthenticate {get;set;}
ProtocolVersion                      Property   version ProtocolVersion {get;set;}
Proxy                                Property   System.Net.IWebProxy Proxy {get;set;}
ReadWriteTimeout                     Property   int ReadWriteTimeout {get;set;}
Referer                              Property   string Referer {get;set;}
RequestUri                           Property   uri RequestUri {get;}
SendChunked                          Property   bool SendChunked {get;set;}
ServerCertificateValidationCallback  Property   System.Net.Security.RemoteCertificateValidationCallback ServerCertificateValidation...
ServicePoint                         Property   System.Net.ServicePoint ServicePoint {get;}
SupportsCookieContainer              Property   bool SupportsCookieContainer {get;}
Timeout                              Property   int Timeout {get;set;}
TransferEncoding                     Property   string TransferEncoding {get;set;}
UnsafeAuthenticatedConnectionSharing Property   bool UnsafeAuthenticatedConnectionSharing {get;set;}
UseDefaultCredentials                Property   bool UseDefaultCredentials {get;set;}
UserAgent                            Property   string UserAgent {get;set;}
#>

$web.GetResponse()

<#
IsMutuallyAuthenticated : False
Cookies                 : {}
Headers                 : {x-amz-id-2, x-amz-request-id, x-amz-version-id, Connection...}
SupportsHeaders         : True
ContentLength           : 7470
ContentEncoding         :
ContentType             : text/html
CharacterSet            : ISO-8859-1
Server                  : CriticalServer/8.88
LastModified            : 12/10/2019 3:32:49 PM
StatusCode              : OK
StatusDescription       : OK
ProtocolVersion         : 1.1
ResponseUri             : https://www.criticalsolutions.net/
Method                  : GET
IsFromCache             : False
#>

$response = $web.GetResponse()

$response | gm

<#
   TypeName: System.Net.HttpWebResponse

Name                      MemberType Definition
----                      ---------- ----------
Close                     Method     void Close()
CreateObjRef              Method     System.Runtime.Remoting.ObjRef CreateObjRef(type requestedType)
Dispose                   Method     void Dispose(), void IDisposable.Dispose()
Equals                    Method     bool Equals(System.Object obj)
GetHashCode               Method     int GetHashCode()
GetLifetimeService        Method     System.Object GetLifetimeService()
GetObjectData             Method     void ISerializable.GetObjectData(System.Runtime.Serialization.SerializationInfo info, System.R...
GetResponseHeader         Method     string GetResponseHeader(string headerName)
GetResponseStream         Method     System.IO.Stream GetResponseStream()
GetType                   Method     type GetType()
InitializeLifetimeService Method     System.Object InitializeLifetimeService()
ToString                  Method     string ToString()
CharacterSet              Property   string CharacterSet {get;}
ContentEncoding           Property   string ContentEncoding {get;}
ContentLength             Property   long ContentLength {get;}
ContentType               Property   string ContentType {get;}
Cookies                   Property   System.Net.CookieCollection Cookies {get;set;}
Headers                   Property   System.Net.WebHeaderCollection Headers {get;}
IsFromCache               Property   bool IsFromCache {get;}
IsMutuallyAuthenticated   Property   bool IsMutuallyAuthenticated {get;}
LastModified              Property   datetime LastModified {get;}
Method                    Property   string Method {get;}
ProtocolVersion           Property   version ProtocolVersion {get;}
ResponseUri               Property   uri ResponseUri {get;}
Server                    Property   string Server {get;}
StatusCode                Property   System.Net.HttpStatusCode StatusCode {get;}
StatusDescription         Property   string StatusDescription {get;}
SupportsHeaders           Property   bool SupportsHeaders {get;}
#>

$response.Headers

<#

PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp> $response.Headers
x-amz-id-2
x-amz-request-id
x-amz-version-id
Connection
X-XSS-Protection
Content-Security-Policy
X-Content-Type-Options
X-Frame-Options
Strict-Transport-Security
Content-Length
Cache-Control
Content-Type
Date
ETag
Last-Modified
Server
#>

$services = Get-Service

if ($services.status -eq 'Running') {Write-host "XX"}

# this becomes a collection and they aren't the same thing.

$services.Name # give all names of all services.

$services = Get-Service
foreach ($service in $services){
    $service.Name
}