Use GameTimeDB;
DELIMITER $$

CREATE TRIGGER AfterNewContribution
AFTER INSERT ON CommunityContributions
FOR EACH ROW
BEGIN
    CALL UpdateUserRole(NEW.Contribution_UserID);
END$$

CREATE TRIGGER log_support_interaction
AFTER INSERT ON TechSupportTicket
FOR EACH ROW
BEGIN
    INSERT INTO `BehaviorLog` (Log_UserID, Log_TicketID, InteractionType, InteractionDate, InteractionDescription)
    VALUES (NEW.Ticket_UserID, NEW.TicketID, 'Support', NOW(), CONCAT('New support ticket created: ', NEW.Issue));
END $$

CREATE TRIGGER RequestFeedbackAfterTimeSpent
AFTER INSERT ON `Review`
FOR EACH ROW
BEGIN
    DECLARE totalTimeSpent INT;

    -- Calculate total game time
    SELECT SUM(TimeSpent) INTO totalTimeSpent
    FROM `Review`
    WHERE User_UserID = NEW.User_UserID
      AND Game_GameID = NEW.Game_GameID;

    -- Check if the total time spent exceeds 180 minutes
    IF totalTimeSpent >= 180 AND NEW.FeedbackRequest = 0 THEN
        -- Insert a new review requesting feedback
        INSERT INTO `Review` (
            `Rating`,
            `ReviewText`,
            `TimeSpent`,
            `Game_GameID`,
            `User_UserID`,
            `ReviewDate`,
            `FeedbackRequest`
        ) VALUES (
            NULL, -- Rating
            'Review for game',
            0, -- TimeSpent
            NEW.Game_GameID, -- Game_GameID
            NEW.User_UserID, -- User_UserID
            NOW(), -- ReviewDate
            1 -- FeedbackRequested
        );

        -- Update the review to mark feedback as requested
        UPDATE `Review`
        SET `FeedbackRequest` = 1
        WHERE `ReviewID` = NEW.ReviewID;
    END IF;
END $$

CREATE TRIGGER FlagUsersForEvent
AFTER INSERT ON `Event`
FOR EACH ROW
BEGIN
    -- Flags users who own game
    UPDATE `UserGame`
    SET `EventFlag` = 1
    WHERE `UserGame_GameID` = NEW.`Event_GameID`;
END $$

CREATE TRIGGER UpdateDemoEngagement
AFTER INSERT ON `UserGameLog`
FOR EACH ROW
BEGIN
    -- Check if the log entry is for a demo
    IF NEW.`GameLog_GameID` IN (SELECT `GameID` FROM `Game` WHERE `IsDemo` = 1) THEN
        -- Update the demo engagement in UserGame
        UPDATE `UserGame`
        SET `Demo` = `Demo` + NEW.`GameDuration`
        WHERE `UserGame_UserID` = NEW.`GameLog_UserID`
        AND `UserGame_GameID` = NEW.`GameLog_GameID`;
    END IF;
END $$

CREATE TRIGGER FlagMobileAccess
AFTER UPDATE ON `User`
FOR EACH ROW
BEGIN
  DECLARE isMobileAccess TINYINT(1);
  -- Update mobile access
  SET isMobileAccess = IF(NEW.`PhoneNumber` IS NOT NULL, 1, 0);
  
  UPDATE `User`
  SET `IsMobile` = isMobileAccess
  WHERE `UserID` = NEW.`UserID`;
END $$

DELIMITER ;

