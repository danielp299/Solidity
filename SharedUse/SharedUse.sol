// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.9/contracts/token/ERC721/ERC721.sol";

//Add this contract to your project to allow shared use of your NFTs
abstract contract SharedUse is ERC721
{
    mapping(uint256 => address) private UserOf;
    mapping(uint256 => uint256) private EndUse;
    mapping(uint256 => address) private BeneficiaryOf;


    event UserAndBeneficiary( uint256 indexed _id, address indexed _newUser,address indexed _newBeneficiary);

    function setUserAndBeneficiary( uint256 _id, address _newUser,address _newBeneficiary, uint8 _days) external{
        require(_setUserAndBeneficiary(_id,_newUser,_newBeneficiary ,_days),"cant shared use");
        emit UserAndBeneficiary(_id,_newUser,_newBeneficiary);
    }
    
    function _setUserAndBeneficiary( uint256 _id, address _newUser,address _newBeneficiary, uint8 _days) internal returns(bool) {
        require(ERC721.ownerOf(_id) == msg.sender,"must be owner");
        
        UserOf[_id] = _newUser;
        BeneficiaryOf[_id] = _newBeneficiary;
        EndUse[_id] = block.timestamp + _days * 1 days;
        return true;
    }
    
    function userOf(uint256 _id) public virtual view returns(address _user, address _beneficiary, uint256 _endUse ){
        
        if(EndUse[_id] > block.timestamp){
            _user = UserOf[_id];
            _beneficiary = BeneficiaryOf[_id];
            _endUse = EndUse[_id];
        }else{
            _beneficiary = ERC721.ownerOf(_id);
            _user = ERC721.ownerOf(_id);
            _endUse = type(uint256).max;
        }
    }
}