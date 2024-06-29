Use GameTimeDB;
DELIMITER $$

CREATE PROCEDURE UpdateUserProfile(
    IN userID INT(9),
    IN newAvatar VARCHAR(45),
    IN newFreeTime TINYINT(2),
    IN newMultiplayerPreference ENUM('Single', 'Coop', 'Large Scale'),
    IN newSocialPlayPreference ENUM('Light', 'Heavy', 'Optional'),
    IN newFriendsList VARCHAR(255)
)
BEGIN
    DECLARE MultiCheck, SocialCheck, FreeTimeCheck BOOLEAN DEFAULT FALSE;

    -- Validate Preferences
    SET MultiCheck = newMultiplayerPreference IN ('Single', 'Coop', 'Large Scale');
    SET SocialCheck = newSocialPlayPreference IN ('Light', 'Heavy', 'Optional');
    SET FreeTimeCheck = (newFreeTime = CAST(newFreeTime AS SIGNED INTEGER));

    UpdateBlock: BEGIN
		IF NOT MultiCheck OR NOT SocialCheck OR NOT FreeTimeCheck THEN
			SELECT 'Invalid input values provided.' AS ErrorMessage;
			-- Exit if validation fails
			LEAVE UpdateBlock;
		END IF;

        UPDATE `UserProfile`
        SET Avatar = newAvatar,
            FreeTime = newFreeTime,
            MultiplayerPreference = newMultiplayerPreference,
            SocialPlayPreference = newSocialPlayPreference
        WHERE UserProfile_UserID = userID;
    END;
END$$

CREATE PROCEDURE GenerateRecommendations(IN userID INT)
BEGIN
    SELECT game.GameID, game.Title
    FROM Game game
    JOIN UserPreferences up ON game.Genre = up.PreferredGenre
    WHERE up.UserID = userID
    ORDER BY game.Rating DESC
    LIMIT 10;
END$$

CREATE PROCEDURE SearchInventory(
    IN inventory_itemRarity INT(3),
    IN inventory_itemGameID INT(9)
)
BEGIN
    IF inventory_itemRarity IS NOT NULL AND inventory_itemGameID IS NOT NULL THEN
        -- Search by both rarity and game ID
        SELECT * FROM Inventory
        WHERE itemRarity = inventory_itemRarity AND item_gameID = inventory_itemGameID;
    ELSEIF inventory_itemRarity IS NOT NULL THEN
        -- Search only by rarity
        SELECT * FROM Inventory
        WHERE itemRarity = inventory_itemRarity;
    ELSEIF inventory_itemGameID IS NOT NULL THEN
        -- Search only by game ID
        SELECT * FROM Inventory
        WHERE item_gameID = inventory_itemGameID;
    ELSE
        -- Validity check
        SELECT 'Not valid search parameters.' AS ErrorMessage;
    END IF;
END$$

CREATE PROCEDURE ApplyGameUpdate(IN gameID INT, IN updateDetails VARCHAR(1000))
BEGIN
    UPDATE Games
    SET CurrentVersion = updateDetails
    WHERE GameID = gameID;
    INSERT INTO GameUpdateLog (GameID, UpdateDetails, UpdateDate)
    VALUES (gameID, updateDetails, NOW());
END$$

DELIMITER $$

CREATE PROCEDURE LogTechSupportIssue(
    IN support_UserID INT,
    IN support_IssueDescription VARCHAR(1000)
)
BEGIN
    INSERT INTO TechSupportTicket (Ticket_UserID, Issue, Status)
    VALUES (support_UserID, support_IssueDescription, 'Open');
END$$

DELIMITER $$

CREATE PROCEDURE CreateCommunityPost(
    IN post_UserID INT,
    IN post_GameID INT,
    IN post_Title VARCHAR(255),
    IN post_Description TEXT
)
BEGIN
    INSERT INTO CommunityPosts (UserID, GameID, Title, Description)
    VALUES (post_UserID, post_GameID, post_Title, post_Description);
END$$

DELIMITER $$

CREATE PROCEDURE UpdateUserRole(IN update_UserID INT)
BEGIN
    DECLARE update_Contributions INT DEFAULT 0;
    -- Calculate contributions
    SELECT COUNT(*) INTO update_Contributions
    FROM CommunityContributions
    WHERE Contribution_UserID = update_UserID;
    -- Check if eligible for upgrade
    IF update_Contributions > 10 THEN
        UPDATE User
        SET Role = 'Community Leader'
        WHERE UserID = update_UserID;
    END IF;
END$$

CREATE PROCEDURE AdvancedGameSearch(
    IN searchTitle VARCHAR(100),
    IN searchPlatform VARCHAR(50),
    IN searchAgeRating VARCHAR(10),
    IN minRating TINYINT,
    IN maxPrice DECIMAL(10, 2),
    IN searchReleaseDate DATE
)
BEGIN
    SELECT 
        game.GameID,
        game.Title,
        game.AgeRating,
        game.Price,
        game.ReleaseDate,
        AVG(review.Rating) AS AverageRating,
        GROUP_CONCAT(DISTINCT platform.PlatformName) AS Platforms
    FROM 
        Game game
        LEFT JOIN Review review ON game.GameID = review.GameID
        LEFT JOIN GamePlatform gamePlatform ON game.GameID = gamePlatform.GamePlatform_GameID
        LEFT JOIN Platform platform ON gamePlatform.GamePlatform_PlatformID = platform.PlatformID
    WHERE 
        (searchTitle IS NULL OR game.Title LIKE CONCAT('%', searchTitle, '%'))
        AND (searchPlatform IS NULL OR platform.PlatformName = searchPlatform)
        AND (searchAgeRating IS NULL OR game.AgeRating = searchAgeRating)
        AND (minRating IS NULL OR AVG(review.Rating) >= minRating)
        AND (maxPrice IS NULL OR game.Price <= maxPrice)
        AND (searchReleaseDate IS NULL OR game.ReleaseDate = searchReleaseDate)
    GROUP BY
        game.GameID;
END $$

DELIMITER ;
