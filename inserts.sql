INSERT INTO `User` (Email, Password, Role, BirthDate, PhoneNumber) VALUES
('Ron@email.com', 'password1', 'Admin', '1985-07-12', NULL),
('Rico@email.com', 'password2', 'User', '1990-08-23', 3249859483),
('Ray@email.com', 'password3', 'User', '1992-11-15', 1627389485),
('Rex@email.com', 'password4', 'Moderator', '1988-03-05', NULL),
('Remmy@email.com', 'password5', 'Admin', '1975-01-22', 1849837462);

INSERT INTO `UserProfile` (Avatar, FreeTime, MultiplayerPreference, SocialPlayPreference, UserProfile_UserID) VALUES
('avatar1.png', 10, 'Coop', 'Heavy', 1),
('avatar2.png', 5, 'Single', 'Light', 2),
('avatar3.png', 8, 'Large Scale', 'Heavy', 3),
('avatar4.png', 12, 'Coop', 'Optional', 4),
('avatar5.png', 7, 'Single', 'Light', 5);

INSERT INTO `Genre` (GenreName, SubGenreName, GenreID) VALUES
('Action', 'Platformer', 1),
('RPG', 'MMORPG', 2),
('Strategy', 'Real-Time', 3),
('Simulation', 'Manager Sim', 4),
('Adventure', 'Dark', 5);

INSERT INTO `Game` (Title, Complexity, FocusLevel, PlayMode, Microtransactions, GameID, IsDemo) VALUES
('Game of Life', 3, 2, 1, 0, 1, 1),
('Action Game', 5, 4, 0, 1, 2, 1),
('Mindgames', 4, 5, 0, 0, 3, 0),
('City Sim', 3, 2, 1, 1, 4, 0),
('Manhunt', 4, 3, 0, 0, 5, 1);

INSERT INTO `GameGenre` (Game_GameID, Genre_GenreID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO `Platform` (PlatformName, PlatformSpecificFeatures) VALUES
('PC', '4K graphics support'),
('Console', 'Exclusive titles'),
('Mobile', 'Touch controls optimized'),
('Virtual Reality', '360-degree view'),
('Cloud', 'Play on any device');

INSERT INTO `GamePlatform` (GamePlatformID, Game_has_Platform_GameID, Game_has_Platform_PlatformID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

INSERT INTO `Review` (ReviewID, FeedbackRequest, Rating, ReviewText, TimeSpent, Game_GameID, User_UserID) VALUES
(1, 0, 5, 'Great game!', 100, 1, 1),
(2, 0, 4, 'Pretty good!', 50, 2, 2),
(3, 0, 3, 'Challenging and fun', 120, 3, 3),
(4, 0, 2, 'It is alright', 30, 4, 4),
(5, 0, 1, 'Trash', 10, 5, 5);

INSERT INTO `Event` (EventDate, Description, Event_GameID) VALUES
('2024-06-01 15:00:00', 'Gaming Convention', 1),
('2024-07-15 10:00:00', 'eSports Tournament', 2),
('2024-08-20 16:00:00', 'Strategy Game Roundtable', 3),
('2024-09-05 14:00:00', 'Simulation Games Expo', 4),
('2024-10-10 09:00:00', 'Game Developer Conference', 5);

INSERT INTO `Achivement` (AchivementDetails, Achivement_GameID, Achivement_UserID) VALUES
('First Win', 1, 1),
('Top Scorer', 2, 2),
('Expert', 3, 3),
('Grandmaster', 4, 4),
('Genius', 5, 5);

INSERT INTO `UserGame` (OwnershipStatus, WishlistStatus, UserGame_UserID, UserGame_GameID) VALUES
(1, 0, 1, 1),
(1, 0, 2, 2),
(0, 1, 3, 3),
(0, 1, 4, 4),
(1, 0, 5, 5);

INSERT INTO `UserGenrePreference` (UserGenPref_UserID, UserGenPref_GenreID, UserGenPref_SubGenreID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

INSERT INTO `GameUpdate` (Game_GameID, GameUpdatecol, UpdateDescription, ReleaseDate) VALUES
(1, 'Patch 1.01', 'Minor bug fixes', '2024-06-01 08:00:00'),
(2, 'Patch 1.02', 'New levels added', '2024-06-15 08:00:00'),
(3, 'Patch 1.03', 'Performance enhancements', '2024-07-01 08:00:00'),
(4, 'Patch 1.04', 'New characters added', '2024-07-20 08:00:00'),
(5, 'Patch 1.05', 'Major update', '2024-08-05 08:00:00');

INSERT INTO `ContentModeration` (ContentModeration_UserID, Approval, ApprovalDate, ContentType) VALUES
(1, 'Approved', '2024-05-10 09:00:00', 'Forum Post'),
(2, 'Denied', '2024-05-11 10:00:00', 'Comment'),
(3, 'Approved', '2024-05-12 11:00:00', 'Review'),
(4, 'Denied', '2024-05-13 12:00:00', 'Video'),
(5, 'Approved', '2024-05-14 13:00:00', 'Image');

INSERT INTO `UserReward` (UserReward_UserID, RewardType, EarnedDate) VALUES
(1, 'Bronze Medal', '2024-05-10 09:00:00'),
(2, 'Silver Medal', '2024-05-11 10:00:00'),
(3, 'Gold Medal', '2024-05-12 11:00:00'),
(4, 'Platinum Medal', '2024-05-13 12:00:00'),
(5, 'Diamond Medal', '2024-05-14 13:00:00');

INSERT INTO `SocialNetwork` (SocialNetwork_UserID, SocialNetworkType, AccountDetails) VALUES
(1, 'Facebook', 'Ron'),
(2, 'Twitter', 'Rico'),
(3, 'Instagram', 'Ray'),
(4, 'LinkedIn', 'Rex'),
(5, 'YouTube', 'Remmy');

INSERT INTO `TechSupportTicket` (TicketID, Ticket_UserID, Issue, Status) VALUES
(5, 1, 'Game does not start', 'Open'),
(4, 2, 'Account locked', 'Resolved'),
(3, 3, 'Payment issue', 'Pending'),
(2, 4, 'Bug report', 'Open'),
(1, 5, 'Feature request', 'Closed');

INSERT INTO `Inventory` (itemID, itemDiscription, itemRarity, item_gameID, item_UserID) VALUES
(1, 'Sword', 5, 1, 3),
(2, 'Dagger', 3, 2, 1),
(3, 'Potion', 1, 3, 4),
(4, 'Armor', 4, 4, 2),
(5, 'Rune', 2, 5, 5);

INSERT INTO `CommunityPosts` (PostID, post_UserID, post_GameID, Title, Description, PostDate, Status) VALUES
(1, 1, 1, 'Game Crash', 'Game crashes when starting.', NOW(), 'Open'),
(2, 2, 2, 'Graphics Glitch', 'Textures are bleeding into each other.', NOW(), 'Open'),
(3, 3, 3, 'Sound Issue', 'No audio.', NOW(), 'Resolved'),
(4, 4, 4, 'Login Problems', 'Account not found.', NOW(), 'Closed'),
(5, 5, 5, 'Patch Update Errors', 'Get an error despite updates.', NOW(), 'Open');

INSERT INTO `CommunityContributions` (ContributionID, Contribution_UserID, ContributionType, ContributionDate, CommunityContributionscol, Contribution_GameID) VALUES
(1, 2, 'Post', NOW(), NOW(), 1),
(2, 1, 'Helpful', NOW(), NOW(), 1),
(3, 5, 'Response', NOW(), NOW(), 1),
(4, 3, 'Post', NOW(), NOW(), 2),
(5, 4, 'Response', NOW(), NOW(), 3);

INSERT INTO `BehaviorLog` (Log_UserID, Log_TicketID, InteractionType, InteractionDate, InteractionDescription)
VALUES
(4, 1, 'Support', NOW(), 'User reported an issue with gameplay.'),
(3, NULL, 'Feedback', NOW(), 'User provided positive feedback on the latest game update.'),
(2, NULL, 'Behavior', NOW(), 'User exhibited abusive behavior in the community posts.'),
(1, 3, 'Support', NOW(), 'User requested help with account.'),
(5, NULL, 'Behavior', NOW(), 'User exhibited abusive behavior in the community posts.');

















