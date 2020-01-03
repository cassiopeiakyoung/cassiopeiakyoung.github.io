/**
 * 
 */

// Import the discord.js module
const Discord = require('discord.js');

// Initialize array of no-no words
var naughtyWords = [];

// Create an instance of a Discord client
const client = new Discord.Client();

/**
 * The ready event is vital, it means that only _after_ this will your bot start reacting to information
 * received from Discord
 */
client.on('ready', () => {
  console.log('I am ready!');



});

// Create an event listener for messages
client.on('message', message => {

  var user = message.author;
  const member = message.guild.member(user);
  let jail = message.guild.roles.find(r => r.name === "In Jail");
  let officers = message.guild.roles.find(r => r.name === "Officers");
  const jailChannel = member.guild.channels.find(ch => ch.name === 'jail')

  if(message.channel===jailChannel){
    if(message.content==="sorry"){
      member.removeRole(jail).catch(console.error);
    } else {
      if(!(message.author.bot)){
        message.reply("you\'ve yee\'d your last haw. You think you can come into my server, swear, be arrested, then attempt to subvert your punishment?");
        var tempUsername = message.author;
        message.channel.send(tempUsername + " has been banished until further notice.");
        const user = tempUsername;

        if(user){
          const member = message.guild.member(user);
          // If the member is in the guild
          if (member) {
            member.kick("Said a banned word, was arrested, and did not serve their punishment.").then(() => {
              // We let the message author know we were able to kick the person
              message.channel.send(`Successfully kicked ${user.tag}`);
              }).catch(err => {
              // An error happened
              // This is generally due to the bot not being able to kick the member,
              // either due to missing permissions or role hierarchy
              message.channel.send('I was unable to kick the member');
              console.error(err);
        
        
            });
          }
        }
      }
    }
  }

  if (message.content.substring(0,5) === '~add ') {
    // Add the term to the naughty words list
    if(message.member.roles.has(officers)){
      naughtyWords.push(message.content.substring(5));
      message.channel.send(message.content.substring(5) + " has been added to the banned words list.");
    } else {
      message.channel.send("Only officers can add a banned word.");
    }
  }

  if (message.content.substring(0,8) === '~remove ') {
    // Removes the term from the naughty words list

    if(message.member.roles.has(officers)){

      var temp = parseInt(message.content.substring(7));
      temp--;
      
      if(0<=temp&&naughtyWords.length>temp){
        var temp2 = naughtyWords[temp]
        delete naughtyWords[temp];
        var i;
        for(i = temp; i < naughtyWords.length-1; i++){
          naughtyWords[i] = naughtyWords[i+1];
        }
        naughtyWords.pop();
        message.channel.send(temp2 + " has been removed from the banned words list.");
      } else {
        message.channel.send("A word of index " + message.content.substring(8) + " was not found in the banned words list.")
      }
    } else {
      message.channel.send("Only officers can remove a banned word.");
    }
    
  }

  if (message.content.substring(0,5) === '~list') {
    // Lists the naughty words
    var listMsg = "Current list of banned words:";

    if(naughtyWords.length==0){
      listMsg = "There are no banned words."
    } else {
      for(x in naughtyWords){
        listMsg += "\n" + naughtyWords[x];
      }
    }

    message.channel.send(listMsg);

  }

  for(x in naughtyWords){
    var temp1 = message.content.toLowerCase();
    var temp2 = temp1.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g,"");
    var potentialBadWord = temp2.replace(/\s{2,}/g," ");

    if((potentialBadWord.indexOf(naughtyWords[x])>-1)&&
    (message.content.substring(0,4)!=="~add")&&
    (!(message.author.bot))){
      message.reply("that's illegal.");
      var tempUsername = message.author;
      message.channel.send(tempUsername + " has been yeeted into the shadow realm.");
      const user = tempUsername;

      let role = message.guild.roles.find(r => r.name === "In Jail");
      
      if(user){
        const member = message.guild.member(user);
        if(member){
          member.addRole(role).catch(console.error);
        }
      }

      
    }
  }
});

// Log our bot in using the token from https://discordapp.com/developers/applications/me
client.login('SAMPLE TOKEN HERE');
