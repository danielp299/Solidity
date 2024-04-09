
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.9/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
pragma solidity >=0.7.0 <0.9.0;

abstract contract ERC721Game2024 is SharedUse, ERC721Enumerable
{
    function tokenOfOwnerByPage(address owner,uint32 page) external view returns(uint256[20] memory items){
            for(uint8 i = 0; i < 20 ; i++){
            if(i + (20 * page) < balanceOf(owner)){
                items[i] = tokenOfOwnerByIndex(owner,i + (20 * page));  
            }else{
                break;
            }
        }
    }
}