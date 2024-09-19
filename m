Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843512BCF7
	for <audit@vger.kernel.org>; Thu, 19 Sep 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774625; cv=none; b=TuxjFFAjJIFPSmb9F9DQtQ9vIokdVNYrZU+efj5rGzTDWuszkZVPXh1Vzb6GodXMctTfKBshISd+04gprsL8ejo0SN0ybVub4i629CNwDkPUknq2BHuY5mPe0a9omB6T/qY/x8SLSIEj+G6hRnc4fMuPkF+54Vw3I5T6exvyRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774625; c=relaxed/simple;
	bh=h7cJFJvH2bii7WYkqUdFJoFaaZT4B06F01W+siRkutA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J1TK7mb1dFTvxgst9C2s2oZcpk3JGTnGH/XVCZ1iPIBEVZc1is13UyGws3FiSiu5jxw08paJAOVNt5DYSQxoNHhkwZglOG82PZFv4/qtoUa0fKteHwmzMSKn6qAIrB5BNONhp/boNqyQU+RvQj8oe2/Qqugmhs5k4ZDP3lTBvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a049f9738fso15011625ab.3
        for <audit@vger.kernel.org>; Thu, 19 Sep 2024 12:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726774623; x=1727379423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CRNWnXG6C62pd73O5+0DURKFiurkyy58Iv9yEaQuwU=;
        b=e80N9BfTAjA6ELOC2JTBS3Qtyk9H/uuY/vgXb/XbetATy24/evA3Zu/S3kpWE+h0II
         k2ubZriz8mU3cnuuhbV/Z8M8cIXzGFuKZG7TkENSQR+7Yg09Bb9EIZP0QobKE2H7XUmc
         Uve1M7DqPjA1orL0hSCbVrOT1LT8h9KPYf7FQhho5tbo+7RM4k+/ZcYqiqW7oneeumld
         l6UyIPBZnh4ZjW414YsQB5PfMw5VnZ4ABw4AIwKjYKRswKUAuA5q9JGZjqdfxvGHtmaA
         Th7+WtHsuvWd+izuOSjx/6H9YFxaKz1TtURzC7A2doxxTZJXJRPyH3PICBxPBw3lq+RA
         p3Rw==
X-Gm-Message-State: AOJu0Yx4PguSpM9ISBxtUEQs+thvUgjlqD9n7LCl2ntlJBOBiGLRDwoG
	Xn9mdw5vw3xDOZRYQPb1AALpLFJ1Ah8KW8zSc4OmWnIDkqVBHJOZiiBAsoJHJCnyBbDRDO8HfM8
	sdunpMI7eOr5KUvRLxgTmJY0WTHLZfNe98XnlkM5OlTBZqOfcryuV5iM=
X-Google-Smtp-Source: AGHT+IEWigGKNkyjia5d2sn1U9cVlDImOMi4LZBpan1NY7y3ryjmidJ6A3/FBWMdIrvH645kOzaYezjv0UDb5xZ8rJdIberjuPNM
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a5:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a0c8c808admr7797375ab.7.1726774623498; Thu, 19 Sep 2024
 12:37:03 -0700 (PDT)
Date: Thu, 19 Sep 2024 12:37:03 -0700
In-Reply-To: <CAHC9VhRpDPTopxgOEbDt1d_XyDVNzaA7++6UojWXidbpBHjeVA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec7d5f.050a0220.29194.0043.GAE@google.com>
Subject: Re: [syzbot] [audit?] general protection fault in smack_log_callback
From: syzbot <syzbot+044fdf24e96093584232@syzkaller.appspotmail.com>
To: audit@vger.kernel.org, casey@schaufler-ca.com, eparis@redhat.com, 
	jmorris@namei.org, john.johansen@canonical.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com
Tested-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com

Tested on:

commit:         2004cef1 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1784c427980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38d475ce6711b8b4
dashboard link: https://syzkaller.appspot.com/bug?extid=044fdf24e96093584232
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162b369f980000

Note: testing is done by a robot and is best-effort only.
