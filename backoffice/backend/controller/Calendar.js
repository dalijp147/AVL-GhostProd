const router = require('express').Router();
const Event = require('../model/Event');
const moment = require('moment');

router.post('/create-Event',async(req,res)=>{
    const event = Event(req.body);
    await event.save();
    res.sendStatus(200)

});

router.get('/get-events',async(req,res)=>{
    const events = await Event.find({
        start:{$gte:moment(req.query.start).toDate()},
        end:{$lte:moment(req.query.end).toDate()},
        title:req.query.title,
    })
    res.send(events);
});

router.delete('/delete-event',async(req,res)=>{
    const event = await Event.findById(req.query.id)
    await event.delete();
    res.sendStatus(200)
});
router.get('/get-events-flutter',async(req,res)=>{
    const events = await Event.find({
      
        title:req.query.title,
    })
    res.send(events);})
module.exports=router;
