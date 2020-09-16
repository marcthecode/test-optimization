trigger Account_Triggers on Account (after update) {
    //new Accounts_Handler().run();
    new OptimizedAccount_Handler().run();
}