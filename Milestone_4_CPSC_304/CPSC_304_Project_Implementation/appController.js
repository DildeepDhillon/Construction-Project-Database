// CODE REFERENCED FROM UBC CPSC 304 NODE PROJECT REPOSITORY

const express = require('express');
const appService = require('./appService');

const router = express.Router();

// ----------------------------------------------------------
// API endpoints
router.get('/check-db-connection', async (req, res) => {
    const isConnect = await appService.testOracleConnection();
    if (isConnect) {
        res.send('connected');
    } else {
        res.send('unable to connect');
    }
});



router.get('/project-table', async (req, res) => {
    const tableContent = await appService.fetchProjectTableFromDb();
    res.json({data: tableContent});
});


module.exports = router;