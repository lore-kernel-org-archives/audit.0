Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681454;
	b=Rf1NfOFhV1azABmt1abN4ny/gOPoir9V9CEJogJgwuMG3RmvzyIE+pys1cU4wpCJ6DS4
	 6caXcKmYPZu+kDgcNoYwF88T6RNcvoHpgjjyKTn66Das4nZnf0HJ8ciGA0LnLUh7M8T32
	 mm9+zAfaipe85qlJmpFQsEcrAblYQ4cR3S/Edy4dtvqFgO859Fn4uSqKA8zJjowJfiF22
	 82atGgWaaODG9EV2jL/aKc4swYHTg8gXre+VvGr3x1WBGji+1EJIy7rXLEyR9jAIWUlQs
	 HgFXaMkbLqk5DiQb5HfHcddPLDFuZN2F6bK8OV1e546Cmv3ZCs42otIwyWTCt8kC3XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681454;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:In-Reply-To:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	b=I+STpzLrvVHHcnZZUB/22IkmSz/q4xYEHOihfIWp2agc06K0K9g9ADt86vfzDWYAFizq
	 yuLg9LtKG1dnDWGq+vv1ALtQ7ZVvNlFzLAS0SagqnNCH6ng00LAZ8UU3PwAeLw4GnPkUN
	 AcHo/luDa+MtNUhO8LfNd1wAPytwI/FRrk70uUZJ+1vlFO4pkyA3n9cPzAapsaR13zn2L
	 r+Z16DrSCN8p1g4HLsg1cjN27wpo8Wipgztxr9aZfJQ/AxZiv5SxFhQ3tnWaA9BBF38fW
	 nsb6Qy6s4Lb4IANmB8ypnBOl224oijAlU28iJaHsbob/77zbcvl0FE0OOGnWWGfmYvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0E606A338
	for <audit@vger.kernel.org>; Thu, 22 Oct 2026 15:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A0E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a45b3f0bdfso2636166b6e.1
        for <audit@vger.kernel.org>; Thu, 22 Oct 2026 08:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681453; x=1793286253;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=V9mjP127QCOzgiJ7eidC6CGp/S4xcXVoWM79NBedliQkiGW38nEoSk9q5LAjuNhSEE
         JFaKry08ql9P75tOxXbA26MGqoIjUuAyjvRNzCULNP4oVB2v+qx+YSM91aFFno+1daic
         2eYqVFiw9C8RSmWC/SrkwhtIjWV3IdZFauppj4WLkjGxEquRaX68zAAw7qiuloKO6pZc
         Ih+NDf+qBAVDOEkTTIIBI+8Zp1hzxCSIE2OGvBorixyIwJTMCsoxbrf2WJwSk8Gn7hsH
         YoFK0NMU3W5wV8F0fznh7HBF/2BNlZb5W/PHCRh/EbSc9Z65wHmQXWYSkGbk90a9L6w2
         nuxg==
X-Gm-Message-State: AFq9FYKgPWA4ZHx3zw+IHOCFtG1r3SdfCqQJzc2wWODjIinrXZeab3J+
	fRFPEud0sS/RTC1yU0PmceQemzhZ7kZdgPUIogKRy12d9OKgrMIMfcoPSoTuYiTc3kzdyrtv4PD
	mSC92mAthfQpJu7S0asQePCMWdqfTyoQ/l+2+zQzHnWAqfueHRBmX5zQLkjU=
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3023:b0:4d6:9153:2968 with SMTP id
 5614622812f47-5535b9c129fmr3664151b6e.57.1792681453267; Thu, 22 Oct 2026
 08:04:13 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:04:13 -0700
In-Reply-To: <6a7aa1a7.b50370da.49fe0.0061.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ada25ed.3ebfcf67.79b0c.0096.GAE@google.com>
Subject: Re: [moderation] KCSAN: data-race in audit_log_start / audit_receive (4)
From: syzbot <syzbot+39b8fea0641107a1ccee@syzkaller.appspotmail.com>
To: audit@vger.kernel.org, bbnpreetsingh@gmail.com, brads@mainlining.org, 
	eparis@redhat.com, linux-kernel@vger.kernel.org, paul@paul-moore.com, 
	syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
