Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1553A63EC
	for <audit@vger.kernel.org>; Wed, 14 Jan 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409474; cv=none; b=g61n/rIUbd3lXMJ36fSkD8h6mj4QllcjWy1AYGtF+YPiBPhd90RO81AI9RpD+WS2TDRo6HYVfG1gLQxfPtDLnEwWfjn2B6w8Dlr2xerKUEawjVWuaFRylXPhrspSzu6c9XqXIostIEXXTsPc8u9sElK3/cFcA0syYZeP7mafT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409474; c=relaxed/simple;
	bh=AfUFgO0b7GPKI9ov+xLUaJEaH3EYfZlGNCRjx7S3gbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJwd5xz6kWpihHRYduh5oTcyMjMXE5MVyKcdMSlDEmT/8+TS7782zmoy49B+LpD8473p6rKZWthhMFiq5yi1fhN1EKhb6vYfk1A6xXib4/U9zKDwuBlB1m9Kg3SMJHuWukJFq03/plUb6XuppBEQ6MLAq19ESKq/7Qq/CDkm/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/tW/0ko; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/tW/0ko"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee4539adfso327085e9.3
        for <audit@vger.kernel.org>; Wed, 14 Jan 2026 08:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768409472; x=1769014272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ3QbmhqfJKikc8lqUdpaAQrOYzjv70oEJ76oRdKAR0=;
        b=M/tW/0kocLeMlzqGk4TuQDsjtbM360FveKnPnHQzhzG5DafyKsh1BzFwabt9D1fkot
         tmpIq/ZwO5y4fpyIzv2aoT5ho+3YyCTuHzBUDbCDzt0/UZePPIbN+ZTIvM+xUik6saIM
         xmfXRcI9s6et5k7OAvs949u8dugPa81Zcb8f2Vahi0oRdOrxkoMdydk7gcIlLKPSLfhX
         hdZep6M5nXDl10HFW58+6nDham0X9ovkDQ7S+FLWfETzI+vsthKYMVOchM5bfV/ewYvy
         ECERRzPsX9d7etHEpp8baX1Al40o6DQPqjVDPyUWa6k+upR3XYpOsKFOWs/tl0Y1zKva
         f1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409472; x=1769014272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQ3QbmhqfJKikc8lqUdpaAQrOYzjv70oEJ76oRdKAR0=;
        b=drz8GU3kdm2xFCT4Oa8byuSLwY6fCAmRFqvs8LiY+s4O4DJNhfuNf3M5QS22jRe5hS
         RwPrvsyBg8kJ1LwHdLykLSr0PCe5+ofzjanLZbadp7JTjAsRBgWZ0EoganWwFgeNgUwx
         CX3mQhFC8bc0NZIkK6synEx/x3ibKIFDmi71WEiiilrAGFASABzg6Izr3a1uDQNuThZD
         1PWbdf9wm5Ggkr9F/aKZLntjeZYDgWlP1h7DfK5lQB21T9a3TUmhJA7gaqnC1aWd0kPJ
         Uj47UGMNMP/Udw5eGM6dL8cjKbsCyBY2g0wjzw8cTVfVKqo4e2aviy2OIzii2Gmy7SST
         IY4g==
X-Forwarded-Encrypted: i=1; AJvYcCXnWLRfwPNwWLNzgUlHfaMdGnquDu4FrEpYng1m4UAY2DZxRRZtjZM0yBbUVogn5mErBsALFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJdxILxMiQQa0EEzOmHpk8JiwPN+qVaA8AVptptqZZW5M6M6V
	lWjAJ7UG+qIFXHhJuVDXRbxvxR4b87vm1ShQuJ3HBhyrTIn1kxAe7vN6
X-Gm-Gg: AY/fxX4YxL023ywVtq+tYtr5M8VhbUlvX3pFCEmrS66m5uLboA41Tikkmos6iV+zfV6
	qZAaGB8JnqbaHRjOLktf4NGXcbSlzLaVffdum7S532KmbCm1mjKx6rl8xwjCB8Qe9k+QltEzQqu
	3f32eqOkx8ucM4hUq9trCRsVgihzV8AjlgvoScaxrS5L6bexBE4919Zwaelk8S8nQYX2b2KPa2F
	BBXMfuXHu2rHezYwoPkZjula1XuuH6OdhrQA8cehoxbLrrJ5v12AF6pAPvQWoEd+ImWr6upg1h0
	oXLc7doudfbKMven8pyBSRW2KaP0Bbu0vliN+pFu7ynMh4x8zXfdh4a02S32VQSNfRqqkg7LzZl
	NjY3K4RnNeAkS+hCGfBljqx8jQp0zyXGwxPpGmiK3zo+w3PmUIvzFR7QRn6j5MawGsvJhAKtPKB
	759arjakcOrp+lZTnDivbart+F+dc59Kn18/PCVapIlbhS74DVNhvh
X-Received: by 2002:a05:600c:a4c:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-47ee338a820mr41712075e9.29.1768409471570;
        Wed, 14 Jan 2026 08:51:11 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653596sm314104f8f.14.2026.01.14.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:51:11 -0800 (PST)
Date: Wed, 14 Jan 2026 16:51:09 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, Paul Moore
 <paul@paul-moore.com>, Jens Axboe <axboe@kernel.dk>, audit@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 68/68] sysfs(2): fs_index() argument is _not_ a
 pathname
Message-ID: <20260114165109.60e46e14@pumpkin>
In-Reply-To: <20260114143555.GV3634291@ZenIV>
References: <20260114043310.3885463-1-viro@zeniv.linux.org.uk>
	<20260114043310.3885463-69-viro@zeniv.linux.org.uk>
	<20260114104155.708180fc@pumpkin>
	<20260114143555.GV3634291@ZenIV>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 14:35:55 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Jan 14, 2026 at 10:41:55AM +0000, David Laight wrote:
> > On Wed, 14 Jan 2026 04:33:10 +0000
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> >   
> > > ... it's a filesystem type name.
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  fs/filesystems.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > > index 95e5256821a5..0c7d2b7ac26c 100644
> > > --- a/fs/filesystems.c
> > > +++ b/fs/filesystems.c
> > > @@ -132,24 +132,21 @@ EXPORT_SYMBOL(unregister_filesystem);
> > >  static int fs_index(const char __user * __name)
> > >  {
> > >  	struct file_system_type * tmp;
> > > -	struct filename *name;
> > > +	char *name __free(kfree) = strndup_user(__name, PATH_MAX);
> > >  	int err, index;
> > >  
> > > -	name = getname(__name);
> > > -	err = PTR_ERR(name);
> > >  	if (IS_ERR(name))
> > > -		return err;
> > > +		return PTR_ERR(name);  
> > 
> > Doesn't that end up calling kfree(name) and the check in kfree() doesn't
> > seem to exclude error values.  
> 
> include/linux/slab.h:523:DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
> 
> kfree() the function won't be even called in that case...

I wasn't expecting the code to be optimised for the pointer being invalid.

I guess one of the defines does a 'dance' so that the pointer can be returned
without kfree() being called - and that needs a check in the function itself.
(I'm sure I remember something about the compiler optimising at all away.)

Perhaps the test could be:
	if (!statically_true(IS_ERR_OR_NULL(_T)) kfree(_T)
adjusting the check in kfree() to ignore -4096..16 not just 0..16.
That should reduce code size without slowing down the 'normal' paths
and possibly speeding up the error paths.

	David

