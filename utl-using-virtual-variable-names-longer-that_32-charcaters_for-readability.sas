Using virtual variable names longer than_32 charcaters_for readability                                                    
                                                                                                                          
If the foreign database uses variable names longer that 32 characters this may help with readability                      
                                                                                                                          
github                                                                                                                    
https://tinyurl.com/y6sxuf4t                                                                                              
https://github.com/rogerjdeangelis/utl-using-virtual-variable-names-longer-that_32-charcaters_for-readability             
                                                                                                                          
SAS Forum                                                                                                                 
https://tinyurl.com/y6563n23                                                                                              
https://communities.sas.com/t5/SAS-Programming/Import-Error-The-variable-contains-more-than-32-characters/m-p/675608      
                                                                                                                          
Problem: The following does not work because some variable names are 38 characters long                                   
                                                                                                                          
/* data from foreign database. Could be CSV. */                                                                           
data have;                                                                                                                
  input                                                                                                                   
        OriginalBorrowerMailFullStreetAddress                                                                             
        BorrowerMailAddressUnitDesignatorCode                                                                             
        BorrowerMailAddressCensusTractAndBlock                                                                            
  ;                                                                                                                       
cards4;                                                                                                                   
MAIN ABCD Z1234                                                                                                           
CAMINO XYXZ Z3456                                                                                                         
;;;;                                                                                                                      
run;quit;                                                                                                                 
                                                                                                                          
ERROR: The variable named ORIGINALBORROWERMAILFULLSTREETADDRESS contains more than 32 bytes.                              
                                                                                                                          
/*                   _                                                                                                    
__      ____ _ _ __ | |_                                                                                                  
\ \ /\ / / _` | `_ \| __|                                                                                                 
 \ V  V / (_| | | | | |_                                                                                                  
  \_/\_/ \__,_|_| |_|\__|                                                                                                 
                                                                                                                          
*/                                                                                                                        
                                                                                                                          
                                                                                                                          
 Original     Borrower       Borrower   ==> Note Column names are 38 characters                                           
 Borrower       Mail           Mail                                                                                       
   Mail        Address        Address                                                                                     
   Full         Unit          Census                                                                                      
  Street     Designator      TractAnd                                                                                     
 Address        Code           Block                                                                                      
                                                                                                                          
  MAIN          ABCD           Z1234                                                                                      
                                                                                                                          
/*         _       _   _                                                                                                  
 ___  ___ | |_   _| |_(_) ___  _ __                                                                                       
/ __|/ _ \| | | | | __| |/ _ \| `_ \                                                                                      
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                                     
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                                     
                          _                                                                                               
 ___ _ __ ___   __ _ _ __| |_   _ __ ___   __ _ _ __                                                                      
/ __| `_ ` _ \ / _` | `__| __| | `_ ` _ \ / _` | `_ \                                                                     
\__ \ | | | | | (_| | |  | |_  | | | | | | (_| | |_) |                                                                    
|___/_| |_| |_|\__,_|_|   \__| |_| |_| |_|\__,_| .__/                                                                     
                                               |_|                                                                        
*/                                                                                                                        
                                                                                                                          
%macro _(vxv);                                                                                                            
  /* often many ways to shorten a names */                                                                                
   %qsysfunc(tranwrd(&vxv,Borrower,B))                                                                                    
%mend _;                                                                                                                  
                                                                                                                          
* Note input data is from db that supports long names. I want to use those names;                                         
data have;                                                                                                                
                                                                                                                          
  label /* interesting label worls without quoting */                                                                     
        %_(OriginalBorrowerMailFullStreetAddress ) = OriginalBorrowerMailFullStreetAddress                                
        %_(BorrowerMailAddressUnitDesignatorCode ) = BorrowerMailAddressUnitDesignatorCode                                
        %_(BorrowerMailAddressCensusTractAndBlock) = BorrowerMailAddressCensusTractAndBlock                               
  ;                                                                                                                       
                                                                                                                          
  input                                                                                                                   
        %_(OriginalBorrowerMailFullStreetAddress)$                                                                        
        %_(BorrowerMailAddressUnitDesignatorCode )$                                                                       
        %_(BorrowerMailAddressCensusTractAndBlock)$                                                                       
  ;                                                                                                                       
cards4;                                                                                                                   
MAIN ABCD Z1234                                                                                                           
CAMINO XYXZ Z3456                                                                                                         
;;;;                                                                                                                      
run;quit;                                                                                                                 
                                                                                                                          
proc print data=have label;                                                                                               
  var                                                                                                                     
   %_(OriginalBorrowerMailFullStreetAddress)                                                                              
   %_(BorrowerMailAddressUnitDesignatorCode )                                                                             
   %_(BorrowerMailAddressCensusTractAndBlock)                                                                             
;                                                                                                                         
run;quit;                                                                                                                 
                                                                                                                          
 Original     Borrower       Borrower   ==> Note Borrower is back                                                         
 Borrower       Mail           Mail                                                                                       
   Mail        Address        Address                                                                                     
   Full         Unit          Census                                                                                      
  Street     Designator      TractAnd                                                                                     
 Address        Code           Block                                                                                      
                                                                                                                          
  MAIN          ABCD           Z1234                                                                                      
  CAMINO        XYXZ           Z3456                                                                                      
                                                                                                                          
