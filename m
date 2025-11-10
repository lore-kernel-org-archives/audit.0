Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01422F261F
	for <audit@vger.kernel.org>; Mon, 10 Nov 2025 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807998; cv=none; b=lfUOrnmN/RV98Iu3ZvjNotiedU8UHZPt0GcI0x1UCmvZl1T5qgup2FBDK0eWFK856RpZDUPlIESUE3j2iTCtjQQYn5V0Ph7pHhEcOzOw2gFzMIvJSYJ2HGd8UNKKgNe+yrf/7TW7/gZoyxbiXULSzCNVTGlfqcu0syZ30VLKJRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807998; c=relaxed/simple;
	bh=JX9r00UWOioSGgY9OIngH/ryyDZlP1m8Vn4QG2kc5H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+m6GQeGn1WVBHdDaeZ0FG5bSEg6oRx07Dqr/c7J+xEyRSD6Wz8ZYLEudTiMcsA8dzOqgDgY9LiaU2JNBvFopqV9nDajHePNugGL+/MzmAIzvMHigV4hm4x0DCz7Nwstp1roU4wKXdH7A6BhVFtrwIMJJkV/lY2s8reodntB7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TPMyloj3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TPMyloj3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so1967861a12.2
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762807995; x=1763412795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf8vYmew6sPCWLS1uooTayzzz1zVmg4FNt5aKYULseU=;
        b=TPMyloj3GXVYYAuGb03fJ32y8sUZNdIYiagEoS6IIUSWB9e4WCLlVQxzV72fQXecO5
         1Xv2viMoeJBn7N0us+sYnT1suZN3JDE1r+qLmoNvCWwZ+ao06CNn1qFGbtPC2jxOAIfY
         MCtwxEmlx+eutS1Exbir4o4oQzgpbA8/E3Rdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807995; x=1763412795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rf8vYmew6sPCWLS1uooTayzzz1zVmg4FNt5aKYULseU=;
        b=OdccPznpxLoCC3G0Rwl59ZvtDk3gt7Vrz1SfPD/Vip6ZevkjmKzjQAXLWWiuHghpnN
         0emJBb9aHqO2J5OCshrLbw7jMQfzNTYdXXoe2lx0MFXHhzWimmL8GHTjJcgc/zkK47Rg
         fQR7xAHNpA1abXMGRev/Acip+60ZsYthxbDYHAWPxNMd3ck/gHuZJts64+VbA4AoDCGZ
         dSdH/eQ1nG9W0Bq42MXO7TcesqIb2NtZFRa/MIdIRn3sTDMFghEGIMJcDMEtAkecuU//
         1ydRH5FJFdCoexZdQSj01lMDijNZWmr0Ox9l9xoIvZ8kP/KlBARHtyEKfplSCtUGYHWP
         FD0w==
X-Forwarded-Encrypted: i=1; AJvYcCVI1uNp8KGsVRlsPiNoBM4NnVxASB344sjQqNqIPIRA8yrQtaaMWV0ET4ymrfSfenKq1hdw8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmG2JjREF+c+4jlLfm5Moug9CTDdZm/PHYTWD7XXmTsBfwKuMA
	MGLurWfsqDvnM6r4aSrsijVzW0mqX6HI9vkipGyc1pjEr1Qpqeha7Q3Iujf/RJh989xUFyyK5vm
	BvPTvxTM=
X-Gm-Gg: ASbGncvjBSDYbHkB7OvzVBmedyz/l3ZQVydiT/zWrCMITY3eHNkzMhYKKh8N9dkpGZ1
	Hc9wghVGzIbDvlY3KpzL0whdG/cixJmgtsNlosAhdVcYWj7Q1yGw508UBraccCJ3yp/41bANHp0
	FMAvk4/1FRqdzZypiq3JPhaXDDLX66PqYn6qTOudC4a+PqHYGVT61uSX/MK04n7yPrwj2j5v+7X
	lsBdP8ibM9DnYrdnfjvlhVQ1i3l9KQ3kXlJsqaDT3V/jW9P8+WDAFfnqxr7theN+PtH04x5bPF7
	RCtFfXmFBjKwsI9BzVzrpuLaWR4MOut9Dtv2ByfC614MvCnzRZ7cuLuZmE+2ly/QVgndgtYGJvN
	mybPYIWBlFBO0VKO5p0yUTciiGdWpaMMWTeUwGv/BcLaj0yOSFAIEBV+rJxZn5sa7YDthqGVjiF
	ZfhEwW0vJXgXZSoiewIK5itnhU8OK/3FGQ3Bj/VxoP2nmPiT/xDQ==
X-Google-Smtp-Source: AGHT+IFvzP19GhON5M3RpvC52XgFhkzQjqRPhKlh33kRKcIwJrQ1Bt17ZAvdgaNp/5J7dH4qERFxvQ==
X-Received: by 2002:a17:906:eecc:b0:b72:dc33:3d36 with SMTP id a640c23a62f3a-b72e056d8e5mr706488666b.49.1762807994952;
        Mon, 10 Nov 2025 12:53:14 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcb043sm1190839066b.6.2025.11.10.12.53.13
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 12:53:13 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so441697566b.2
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 12:53:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxrwoi6roRd9RZhIcWdQGEv/C85jxNtK4NlrAVc8X3qL+bAJsJe6NPUANYuivfMo/WgXcz7w==@vger.kernel.org
X-Received: by 2002:a17:907:7b96:b0:b40:fba8:4491 with SMTP id
 a640c23a62f3a-b72e0310d6fmr1100087666b.17.1762807993264; Mon, 10 Nov 2025
 12:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAHk-=wjA=iXRyu1-ABST43vdT60Md9zpQDJ4Kg14V3f_2Bf+BA@mail.gmail.com>
 <20251110051748.GJ2441659@ZenIV> <CAHk-=wgBewVovNTK4=O=HNbCZSQZgQMsFjBTq6bNFW2FZJcxnQ@mail.gmail.com>
 <20251110195833.GN2441659@ZenIV>
In-Reply-To: <20251110195833.GN2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Nov 2025 12:52:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3vpw5W6rV6VKxa9PYF3Xwn5_6AT=OwqBWO79g6N1B_A@mail.gmail.com>
X-Gm-Features: AWmQ_blj7UCkHVNWD8MxILQgPkvzV6LzxIw6bD27yUdHSxmjHA7zzLofljDreO4
Message-ID: <CAHk-=wi3vpw5W6rV6VKxa9PYF3Xwn5_6AT=OwqBWO79g6N1B_A@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	mjguzik@gmail.com, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 11:58, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> If we go that way, do you see any problems with treating
> osf_{ufs,cdfs}_mount() in the same manner?  Yes, these are pathnames,

Hmm. In those cases, the ENAMETOOLONG thing actually does make sense -
exactly because they are pathnames.

So I think that in those two places using getname() is fairly natural
and gets us the natural error handling too. No?

              Linus
