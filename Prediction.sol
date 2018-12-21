pragma solidity >=0.4.25 <0.6.0;

contract Prediction {
    
    address private owner;
    
    mapping(bytes => string) private predictionMap;
    // set as public and can be viewed by anyone
    int public uniquePredictions = 0;
    int public predictions = 0;
    
    constructor() public {
        owner = msg.sender;
    }
    
    event PredictionEvent(string blockTESTUserId, string value, int predictions, int uniquePredictions);
    
    // taking a value as string to make it easy to store the predictions
    function predict(string memory blockTESTUserId, string memory val) public {
        // making sure only owner can post the predictions
        require (tx.origin == owner, "Only owner can post predictions!");
        
        // making sure this is user's first prediction (unique)
        if (bytes(predictionMap[StringAsKey.convert(blockTESTUserId)]).length == 0)
            uniquePredictions += 1;
        predictions += 1;
        predictionMap[StringAsKey.convert(blockTESTUserId)] = val;
        
        // emitting event
        emit PredictionEvent(blockTESTUserId, val, predictions, uniquePredictions);
    }
    
    // access this function to get your prediction
    function getPrediction(string memory blockTESTUserId) public view returns (string memory) {
        return predictionMap[StringAsKey.convert(blockTESTUserId)];
    }
}

library StringAsKey {
    function convert(string memory key) public pure returns (bytes memory ret) {
        if (bytes(key).length > 40) {
          revert("Key length > 40!");
        }
    
        assembly {
          ret := mload(add(key, 40))
        }
    }
}
