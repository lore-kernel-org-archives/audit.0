Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38DF287265
	for <audit@vger.kernel.org>; Mon, 10 Nov 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793433; cv=none; b=dQj5cDudd6P5ORXLrqiA/b4AJxaUYGDmqstnt9A1CqKJCf+gK4UMJ8j09cvkXe/EJ1+u/56qX9bOVkWpm8whkD3OGz9rFfLXiGgHV6OlkSeUJcXPH1tnCXaD0FdgIpZ1egv9hDY9ed2sPb2Grq/BXKeOqIDrDZVAoRo3qOJQeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793433; c=relaxed/simple;
	bh=XltYOg7k6APNYxmEk9YbYTSDtH+b3EpjGO8HEYY9tKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5M1NeeihfZ2TNCMmc0k/hll0clguIfahxci/c/LEHNMYGJ7G++2RIKlncA6dgCacLwsEsC7lcJoe0h6oAgmiGVVAyhG1lW1VAdlNTz+EWFNgMW8NceNKYjpVTMcwv8DuYOvVQ9VSoUkN3tHr0JgN2mihGODEsBDcLJMvlzTefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WBhRZsyK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WBhRZsyK"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b710601e659so517813966b.1
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762793430; x=1763398230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DkZN9c+POTwUaLOiQGKa5zH5Hbhc5P5pBlVymH+hWeM=;
        b=WBhRZsyK3uXZqCRQp+udiiAFKy4NmkYOafMNTV/DZ3hz0rt9ixFD3Ryq3I50J6QVYD
         HfWXRN70SwWhz/Odl3Q9mrbAaR9fXtuauqDNfUkpjpE/ZrHRDxduu6PQSbjNUyQO/+OF
         /sh8TDIaC2Am6RemFKm3ORB+a4T4BcyZ0QU5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793430; x=1763398230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkZN9c+POTwUaLOiQGKa5zH5Hbhc5P5pBlVymH+hWeM=;
        b=SY+lGGjtyG1O15F4tZU/VpdtIncv/C3GXDXaP3WFz9JicxunT7pAQYcDZXVE6b21Mj
         jeMB4u8X5MnxXncXFrHl79ogi0HPbgGU3B+JRA25C2nZih0l/m8AnlZoWmwzgPadVmOo
         DI0/z48/hvorbzCXOYQ+OIbmG04OopAXeGqJNmVNwALS0CB9jp2MCaDKgy9rnk/wJ7a2
         mDG9hEKdjBPEaM5epcJ9VIjWLic1/2w0l6pYmR1UidoxoIg6LBHSTvY3zbYrF0sI1vKm
         80PD1RH9lWLE+9Y0reZStf++0o5QU4iZ4+1FbNH9jm9mdUZ8Y/PPM4jbYXzRuErqxp8m
         gcGg==
X-Forwarded-Encrypted: i=1; AJvYcCUyoelwzJjCMy3uk3xOsA649XU3ccgzfOn5BWhuwuZZ3DtKqn5k8wqRdlVHduy17MxfCBME6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRYWhnLDxCXJIxQQIZ94HOLqVnVHxi7PqSvMo81CifX2hFYNUA
	4P4QkCSqbTYfoiyZDXf26zoYtONpvoOHzCy4eFhVTIEALaLjy3nBc21lof1a0tfJRTXimH+6hyX
	qtmehHWA=
X-Gm-Gg: ASbGncti0DOzi2S/yXH8OrDkvAIt1I2saW8CSFxj0rdKK0qQraVCaoiy040RL0VjzA8
	PNrCKL3bUhbJlNMFcc1YbWZXIijI4HIG8HmMfvENAeePdMKyBMq6QNf0P+EcZWBJ/Xn+g4LSp5P
	3rLghhpb+gUt7J/9LIumIj1R5ZUyCWjT3iiJ6BumODXmHHc1QAF1CDZQgLJxKmar6orT7MDctOh
	yaqIMy787zo5cN32hZyHSy3qVhO+Kkk4afleklfi7Zy/uT/tBSancCq9k1UFYeVQOVUFtyXRXoZ
	sYtBvOK7M1V2A2y84tQyJU5eaNTY3RYX+Lm9XWUcCM9aN7g6U+GyJLsNokq2m8U5aVUGDdKKVrB
	lc3OafGqfcIhYzwe+j7ZslpUlbR4vH/GxNYSx2arE2Zm09LuNasQKJ+Cmn/wGBOomJyevH2S3j0
	gDi82D0039UF3rIBrQbqAinwr5m0NupDaita6hya+JurGg2e94MuZEZEQUpAKN
X-Google-Smtp-Source: AGHT+IFE6j0YsSpRIkUD8Ic+LfGR6z8FUXAtjQfdG7/7WSBv14OZf9FfNtlTPeFU0I8ir1yR24UEiA==
X-Received: by 2002:a17:907:a4c:b0:b71:8448:a8bf with SMTP id a640c23a62f3a-b72e05213edmr726672166b.62.1762793429824;
        Mon, 10 Nov 2025 08:50:29 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea51sm1119116666b.4.2025.11.10.08.50.27
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:50:28 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so3105343a12.0
        for <audit@vger.kernel.org>; Mon, 10 Nov 2025 08:50:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVohtQYDEfaIVFcs0MUSG5IpUNGyymeXqEdCWgThQhRApgf7NPBO3wwpOblUnj0LJlWRo7GLw==@vger.kernel.org
X-Received: by 2002:a17:907:da3:b0:b72:a899:168a with SMTP id
 a640c23a62f3a-b72e031d007mr811932266b.28.1762793427368; Mon, 10 Nov 2025
 08:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAHk-=wjA=iXRyu1-ABST43vdT60Md9zpQDJ4Kg14V3f_2Bf+BA@mail.gmail.com> <20251110063658.GL2441659@ZenIV>
In-Reply-To: <20251110063658.GL2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Nov 2025 08:50:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxqWfNmPuE59P56Q-U29he2x3BO9C0Q4bUPphBtNdQpg@mail.gmail.com>
X-Gm-Features: AWmQ_bne3SudUbW59AJIrZv5w1KqgWCmrYPp42xrhe0AZmxb-UOp-XffXDbOnBM
Message-ID: <CAHk-=whxqWfNmPuE59P56Q-U29he2x3BO9C0Q4bUPphBtNdQpg@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	mjguzik@gmail.com, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 22:37, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > @@ -258,13 +264,13 @@ struct filename *getname_kernel(const char * filename)
> >
> >               tmp = kmalloc(size, GFP_KERNEL);
> >               if (unlikely(!tmp)) {
> > -                     __putname(result);
> > +                     free_filename(result);
> >                       return ERR_PTR(-ENOMEM);
> >               }
> >               tmp->name = (char *)result;
> >               result = tmp;
>
> That's wrong - putname() will choke on that (free_filename() on result of
> kmalloc()).

Yeah, that's me not doing the right conversion from the old crazy
"turn allocations around".

It should just do

                char *tmp = kmalloc(len, GFP_KERNEL);
                .... NULL check ..
                result->name = tmp;

without any odd games with types. And yeah, that code could be
re-organized to be clearer.

             Linus
