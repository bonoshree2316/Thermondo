/*
* Name            :    NPSAPIWrapper
* Description     :    This is the Wrapper class to send the order data to NPSAPI for Fulfilled order
* Created Date    :    [24th November , 2022]
* Created By      :    [Bonoshree Mondal]
*
* Date Modified        Modified By             Description of the update
   24th-Nov-2022      Bonoshree Mondal          Created

*/
public class NPSAPIWrapper {
        public String sfId;
        public String orderNumber;
        public String customerEmail;
		
		public NPSAPIWrapper(Order o){
			this.sfId = o.Id;
			this.orderNumber = o.OrderNumber;
			this.customerEmail = o.Account.PersonEmail;
		}
        
}