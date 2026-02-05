Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205819E968
	for <audit@vger.kernel.org>; Thu,  5 Feb 2026 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314028; cv=pass; b=c9hxTYpXPgdjJwq8TSQF4I3brPrs60SsDJg8+8aXVhnoTf4e0VcaKZknvDgxltfNkSNjhqGV+8Eu+azbY1xI7K6QWKNz02fmBIdwY9q3tFYXWj/0SrOoz+gDYl18MAJ+SJkyHkk8xaBd2elRTZ4vrVDNwn1oJ6HSy1Czbqjj5Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314028; c=relaxed/simple;
	bh=OWhxJIGXChvhgvIfUq1ZHwaw4GS0zppNwdQUaqQJiTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCffEZqA6gC0aZpRgedgnOF3ESjBBPcih3cx8Ugk5yYMslFC47+a3CxYvwPaMY0z+fwQV7IA3R6yBAtXN8Mu1z+ae1+tA184u78aGrrV+wVfvEYDrqnAXFNbXVh21QS59FOXQUARCP3gxQs0ks4GrMkayGaWYmsXHwrVoJBFBrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpPGcdse; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpPGcdse"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65814266b08so1878181a12.3
        for <audit@vger.kernel.org>; Thu, 05 Feb 2026 09:53:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770314026; cv=none;
        d=google.com; s=arc-20240605;
        b=YjBXtjz0bNrnhJR9KLCpenU3nmv7H4DVBOIiNaJPMo7dxU3DeaHkOrRC283YQLFAuo
         JcwFTVezF5Eo6QqwaSuqLJmBYnaYGoQHoPBzcf1ZZkFzwg0HvOnIQRtf45BfaY80XF+Z
         2ZtQhNtwtzSs+9CWD/46bJqS2w1WtJ7n/KZGZBn4qoF7/cW7M/g2KRl5ZWORvW+BtJks
         s1RLrCqcbGZFtbVJk1NjtmOJvARfr0gDAeGxTvmnXTxWLXC/ORlesqMZ92rrJ/8kmbmz
         hDeUgttw9LKH0L0p4Tg192IT8WQL2xRKFtcJ90X6nkLhuVJsYctJTZy0kCxBIB/1gAWG
         W4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CtmbHGdNQ6+8QDVCfxuDJcCBTglbsHR4tQyJ74FyXRg=;
        fh=qrIcSWD6IVpfBkK55by84wSgRw5FBWAwYpqFVClAdA8=;
        b=SfwuHkrlpniEkyt5CrP6WneSm/lF2QD26nQsWFrl8mxIYousJHVxT5DNW1whJDwZCY
         W3Tag+eIt9evBHhKA/UC7ejdODrGk9QZ0O3MpJj2oVIN8qGm3focaE9Lhz3Cpct+l7wg
         RiAt91pBGfevxlo7hpXq87j458ifuLExyFZjB9epbQCPkA9o71Mt2oLAYZBiFSvqsm3N
         6gkG05kVXewCrJYcvIcSrzvMKSQeWEXB9J4cJG5Q+JVNjAzsaoxglE1sibKWX7PF+ZoA
         gWSzSvq6oLn473nnkmGmFb+Kcm2YKK0tU0z2gJMYC5pDl/6MxvGQbMo/FOZRV9Tnx7Gv
         +Iqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770314026; x=1770918826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtmbHGdNQ6+8QDVCfxuDJcCBTglbsHR4tQyJ74FyXRg=;
        b=VpPGcdseuAgoVS+U+fvqDj/mFOfOGGOkGUPX8iLKaWcZjfJQiAnBAnF7x7RNbkoqNJ
         SKR9lVkMTbnomOsb4paHbFiTvZQhX6CdYe4xY9L6O4YuJKxK3gcumVN1msASGYUIW44F
         HNCc+IAbMGMg1Nwm++B8kjuCI/3mhPbkhYFV+Ol9OcD2GV6FcynSa+49OgMgkUOIZZwG
         MMMEbjqN9+rzl9o5sTe1IbVg27O5dtvbn0C5AmNtQPAQyGWH4t7Cdk7RkH6uO711avFj
         aLCtTi9/sODe1fqZC4q3unIxU9guXIcYJ63Na+uUH6HgKvdLgDtkQeCQjP3g359v+o0n
         BVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770314026; x=1770918826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CtmbHGdNQ6+8QDVCfxuDJcCBTglbsHR4tQyJ74FyXRg=;
        b=UJgR8pMDruK8Hi4LUdyJCViBIdGKeCboN+8/jkcgM709cNa9rf0UAqIgk6yus/PHVm
         KLITrHE+XkMgXqPXscAcjibsmWmrdhY6H4BiXQ3qj7XajXvXgGJNtD08sB7gGHAkIFqj
         d/dZ9tVWtJQCUDJfR8xuGy+ti46Heuv25Y+Fedx1mqFTlb6EusDNkUmAkGjUpxcRiex9
         2gmE/AOOpbleonB0W9Rf9Ttq3rWFmqBzQqGquo0Qu9OvFzI5YhSA60eX1QZiDa0SapmN
         k6Y2w0HNF+XprkwHVFeCzUBLuBl9Scgy8XFICm5UFnTfW7ArDDJEzBEwWDCOvqdIbuLR
         llSw==
X-Forwarded-Encrypted: i=1; AJvYcCUuBT0LZJH75akP7oOzreW8IQMCApHppiwwRG5UZPPATw/a0gZnURjMwhg3qOgjVdCVMnLU+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUnH8Aklvf9jKySNWoc88hp8pE9xC8kZUuBXQUGY3ofwsdBKD
	DPKTFL3isrqYNFxIqXLGw9b0InGenl18zYEW8l/3ERGP2DFYqNeAsGrRVwvmMPHU/8TsDieisUr
	NYYg2VVKWD15HuqDs56JzGt7kWrtCl88=
X-Gm-Gg: AZuq6aIpgC9R+gDeHeUoJkneRZD7a1CrwArlzn2miziZSWHz06Pk1QaVkaU8CZCsZ5d
	6zbMENxKMTB7Zm4Gl6EfomUeHJ1zEk03D1DikOWh4LsHJmy5FBLyzirAHt6gaoQ1Qmwsp2gKD4P
	ULujiDwgiJfuQG68tLgwZ8rXIeAVaxwZ2U+JZ+QT4k9WhOlMSA+iue1TgpC2pxQUXVQKD1juCss
	4Pxr4FrBPMQJApYqXH2/2cIQ0zeyodvSq4aNADMksSvTp1RQnnVavUI2AkDFW851A7N93dsOPHH
	0HmTsSgqq3QZO9RAAqaTDz0/SzI=
X-Received: by 2002:a17:907:db02:b0:b8e:3877:d1bc with SMTP id
 a640c23a62f3a-b8e9f156dfdmr512500266b.16.1770314025966; Thu, 05 Feb 2026
 09:53:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203194433.1738162-1-longman@redhat.com> <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com> <20260203215002.GI3183987@ZenIV>
 <20260203232634.GJ3183987@ZenIV> <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV> <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV> <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
 <20260205052202.GQ3183987@ZenIV>
In-Reply-To: <20260205052202.GQ3183987@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 5 Feb 2026 18:53:34 +0100
X-Gm-Features: AZwV_QhO1LyY6ekAt9YhPWqCKCtAuMHZoW2S9lCv01SSvYAO-Xwq4YBj7CY1tWU
Message-ID: <CAGudoHFz1QZdYTp=PbAF+v-3-EZhwL0PQz+Zv0nNTG0WCSAdAw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Waiman Long <llong@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>, 
	Ricardo Robaina <rrobaina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 6:20=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> Mateusz: *is* there a measurable effect?  Because if there isn't, I'm
> very tempted to simply revert that thing.  "Churn of adding fs_struct.h
> as needed" is not the problem - try "exposing the object internals to
> far larger subset of the kernel".  We had interesting bugs with weird
> shit deciding to poke in there, locking and refcounting be damned.

This one I did not bother benchmarking as it is an obvious change --
read a var directly instead of going through a func call.

If this is causing trouble then it definitely needs to be reverted,
but any woes only speak to the mess in the header files.
